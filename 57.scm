(define (if-fun exp1 exp2 exp3)
 (if exp1 exp2 exp3))

(define (fact4 n)
 ((if-fun (> n 0) (lambda() (* n (fact4 (- n 1)))) (lambda() 1))))
