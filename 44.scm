(define (my-gcd a b)
  (if (< a b) (my-gcd b a)
    (if (zero? b) a
      (my-gcd b (modulo a b)))))
