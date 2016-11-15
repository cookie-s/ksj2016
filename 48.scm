(define (_func n res1 res2)
  (if (= n 0) res2 (_func (- n 1) res2 (+ res2 res1))))

(define (fib2 n) (_func n 0 1))
