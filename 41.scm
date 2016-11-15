
(define (min-of-four a b c d) 
  (let ((mi (lambda(a b) (if (< a b) a b))))
  (mi (mi (mi a b) c) d)))

