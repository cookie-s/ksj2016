(define (stack-push st val) (cons val st))
(define stack-read car)
(define stack-pop cdr)

(define (calc-fun st op)
  (stack-push (stack-pop (stack-pop st)) (op (stack-read (stack-pop st)) (stack-read st))))
(define (calc-add st) (calc-fun st +))
(define (calc-sub st) (calc-fun st -))
(define (calc-mul st) (calc-fun st *))
