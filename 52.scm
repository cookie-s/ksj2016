(define (my-foldl op acc l)
 (if (null? l)
  acc
  (my-foldl op (op (car l) acc) (cdr l))))

(define (my-assoc2 key lst)
 (my-foldl (lambda(lst res)(if (equal? (car lst) key) lst res)) #f lst))
