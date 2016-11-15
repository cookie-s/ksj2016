(define (_my-reverse lst res)
 (if (pair? lst) (_my-reverse (cdr lst) (cons (car lst) res)) res))

(define (my-reverse lst) (_my-reverse lst '()))
