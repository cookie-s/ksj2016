(define (plus-naive a b)
  (if (<= a 0)
    b
    (+ (plus-naive (- a 1) b) 1)))
