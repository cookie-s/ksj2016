(define (_func n res)
  (if (= n 0) res (_func (- n 1) (* res n))))

(define (fact2 n) (_func n 1))
