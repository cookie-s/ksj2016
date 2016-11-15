(define (fix f)
  (lambda (x) ((f (fix f)) x)))

(define (fact5 n)
 ((fix (lambda(f)(lambda(m)(if (zero? m) 1 (* m (f (- m 1))))))) n))
