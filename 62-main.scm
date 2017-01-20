(load "62.scm")

(define (scheme)
  (let ((top-env (make-top-env)))
    (define (rep-loop env)
      (display "sister> ")
      (let ((res (base-eval env (read))))
        (let ((env (car res)) (val (cdr res)))
          (print-data val)
          (newline)
          (if (equal? val '*exit*)
            #t
            (rep-loop env)))))
    (rep-loop top-env)))

(scheme)
