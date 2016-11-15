(define (fib n)
  (if (or (zero? n) (equal? n 1)) n
    (+ (fib (- n 1)) (fib (- n 2)))))
