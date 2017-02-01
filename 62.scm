(define (make-frame param)
  (define frame param)
  (define (update var val)
    (set! frame (cons (cons var val) frame)))
  (define (lookup var)
    (assoc var frame))
  (define (show) (display frame))
  (define (dispatch m)
    (cond ((equal? m 'update) update)
          ((equal? m 'lookup) lookup)
          ((equal? m 'show) show)
          (else #f)))
  dispatch)

(define (make-env param)
  (define env param)
  (define (extend) (let ((newenv (make-env env))) ((newenv 'extend!)) newenv))
  (define (extend!) (set! env (cons (make-frame '()) env)))
  (define (set var val) (((car env) 'update) var val))
  (define (show) (map (lambda (frm) ((frm 'show))) env))
  (define (lookup var)
    (letrec ((lookup-loop (lambda (var frames)
                            (if (null? frames) 'not-found
                              (let ((found (((car frames) 'lookup) var)))
                                (if found found (lookup-loop var (cdr frames))))))))
      (lookup-loop var env)))
  (define (dispatch m)
    (cond
      ((equal? m 'extend) extend)
      ((equal? m 'extend!) extend!)
      ((equal? m 'set) set)
      ((equal? m 'lookup) lookup)
      ((equal? m 'show) show)
      (else #f)))
  dispatch)

(define (make-closure env params body)
  (define (dispatch m)
    (cond
      ((equal? m 'class) 'closure)
      ((equal? m 'env) env)
      ((equal? m 'params) params)
      ((equal? m 'body) body)
      (else #f)))
  dispatch)

(define (make-primitive fun)
  (define (dispatch m)
    (cond
      ((equal? m 'class) 'primitive)
      ((equal? m 'fun) fun)
      (else #f)))
  dispatch)

(define (make-error id message)
  (define (show)
    (display (cons id message))
    (newline))
  (define (dispatch m)
    (cond
      ((equal? m 'class) 'error)
      ((equal? m 'show) show)
      (else #f)))
  dispatch)

(define (make-exit)
  (define (dispatch m)
    (cond
      ((equal? m 'class) 'exit)
      (else #f)))
  dispatch)

(define (what obj)
  (cond
    ((equal? '*unspecified* obj) 'unspecified)
    ((number? obj) 'number)
    ((string? obj) 'string)
    ((boolean? obj) 'boolean)
    ((symbol? obj) 'symbol)
    ((list? obj) 'list)
    (else (obj 'class))))

(define (constant? obj)
  (or (number? obj) (or (string? obj) (boolean? obj))))

(define (make-eval p-env)
  (define env ((p-env 'extend)))

  (define (emit-error type message)
    (display (cons type message)) (newline))

  (define (var-eval body)
    (let ((res ((env 'lookup) body)))
      (if (equal? res 'not-found) (emit-error 'unbound-variable body) (cdr res))))

  (define (def-eval body)
    (if (pair? (car body))
      (begin ((env 'set) (caar body) (evaluate (cons 'lambda  (cons (cdar body) (cdr body))))) (caar body))
      (begin ((env 'set) (car body) (evaluate (cadr body))) (car body))))

  (define (let-eval body)
    (let ((leteval (make-eval env)))
      (map (lambda(envval) ((leteval 'evaluate) (cons 'define (list (car envval) (evaluate (cadr envval)))))) (car body))
      (letrec ((let-eval-loop (lambda (left)
                                (if (null? (cdr left))
                                  ((leteval 'evaluate) (car left))
                                  (begin ((leteval 'evaluate) (car left))
                                         (let-eval-loop (cdr left)))))))
        (let-eval-loop (cdr body)))))

  (define (letrec-eval body)
    (let ((leteval (make-eval env)))
      (map (lambda(envval) ((leteval 'evaluate) (list 'define (car envval) (cadr envval)))) (car body))
      (letrec ((let-eval-loop (lambda (left)
                                (if (null? (cdr left))
                                  ((leteval 'evaluate) (car left))
                                  (begin ((leteval 'evaluate) (car left))
                                         (let-eval-loop (cdr left)))))))
        (let-eval-loop (cdr body)))))

  (define (lambda-eval body)
    (make-closure env (car body) (cdr body)))

  (define (if-eval body)
    (if (evaluate (car body)) (evaluate (cadr body)) (evaluate (caddr body))))

  (define (begin-eval body)
    (if (null? body)
      #f
      (let ((res (evaluate (car body))))
        (if (null? (cdr body))
          res
          (begin-eval (cdr body))))))

  (define (quote-eval body) (car body))

  (define (load-eval body)
    (with-input-from-file (car body)
                          (lambda()
                            (letrec ((re-loop (lambda()
                                                (let ((val (evaluate (read))))
                                                  (if (equal? val '*exit*) (car body) (re-loop))))))
                              (re-loop)))))

  (define (apply-eval body)
    (let ((res (map evaluate body)))
      (evaluate (cons (car res) (cadr res)))))

  (define (cond-eval body)
    (if (null? body) '*unspecified*
      (let ((current (car body)))
        (if (equal? (car current) 'else) (evaluate (cdr current))
          (if (evaluate (car current))
            (evaluate (cadr current))
            (cond-eval (cdr body)))))))

  (define (map-eval body)
    (let ((map-args (map evaluate body)))
      (apply map (cons (lambda args (evaluate (cons (car map-args) args))) (cdr map-args)))))

  (define (app-eval body)
    (let ((res (map evaluate body)))
      (let ((f (car res)) (p (cdr res)))
        (if (equal? (f 'class) 'primitive)
          ((f 'fun) p)
          (let ((ev (make-eval (f 'env))))
            (if (list? (f 'params))
              (map (lambda (var val) ((ev 'evaluate) (list 'define var val))) (f 'params) p)
              ((ev 'evaluate) (list 'define (f 'params) p)))
            (letrec ((app-eval-single-loop (lambda(left)
                                             (let ((res ((ev 'evaluate) (car left))))
                                               (if (null? (cdr left))
                                                 res
                                                 (app-eval-single-loop (cdr left)))))))
              (app-eval-single-loop (f 'body))))))))

  (define (evaluate exp)
    (cond
      ((eof-object? exp) '*exit*)
      ((constant? exp)   exp)
      ((symbol? exp)     (var-eval exp))
      ((not (pair? exp)) exp)
      ((equal? (car exp) 'exit) '*exit*)
      ((equal? (car exp) 'define) (def-eval (cdr exp)))
      ((equal? (car exp) 'let) (let-eval (cdr exp)))
      ((equal? (car exp) 'letrec) (letrec-eval (cdr exp)))
      ((equal? (car exp) 'lambda) (lambda-eval (cdr exp)))
      ((equal? (car exp) 'if) (if-eval (cdr exp)))
      ((equal? (car exp) 'begin) (begin-eval (cdr exp)))
      ((equal? (car exp) 'quote) (quote-eval (cdr exp)))
      ((equal? (car exp) 'load) (load-eval (cdr exp)))
      ((equal? (car exp) 'apply) (apply-eval (cdr exp)))
      ((equal? (car exp) 'cond) (cond-eval (cdr exp)))
      ((equal? (car exp) 'map) (map-eval (cdr exp)))
      (else (app-eval exp))))

  (define (show)
    ((env 'show)))

  (define (dispatch m)
    (cond
      ((equal? m 'class) 'evaluate)
      ((equal? m 'evaluate) evaluate)
      ((equal? m 'show) show)
      (else #f)))
  dispatch)

(define top-env
  (let ((passthru (lambda (fun) (make-primitive (lambda (args) (apply fun args))))))
    (list
      (cons '+ (passthru +))
      (cons '- (passthru -))
      (cons '* (passthru *))
      (cons '/ (passthru /))
      (cons '< (passthru <))
      (cons '> (passthru >))
      (cons 'equal? (passthru equal?))
      (cons 'cons (passthru cons))
      (cons 'list (passthru list))
      (cons 'car (passthru car))
      (cons 'cadr (passthru cadr))
      (cons 'cdr (passthru cdr))
      (cons 'display (make-primitive (lambda(args)(display (car args)) '*unspecified*)))
      (cons 'newline (make-primitive (lambda(args)(newline) '*unspecified*)))
      ;(cons 'with-input-from-file (passthru with-input-from-file))
      (cons 'read (passthru read))
      )))

(define (make-top-env) (make-eval (make-env (list (make-frame top-env)))))

(define (base-eval env exp) (cons env ((env 'evaluate) exp)))

(define (print-data data)
  (let ((type (what data)))
    (cond
      ((equal? 'number type) (display data))
      ((equal? 'string type) (display data))
      ((equal? 'boolean type) (display data))
      ((equal? 'symbol type) (display data))
      ((equal? 'list type) (display data))
      ((equal? 'unspecified type))
      (else (display type)))))