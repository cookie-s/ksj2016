
(define (my-assoc key dict)
 (if (null? dict) #f
  (if (equal? key (car (car dict))) (car dict) (my-assoc key (cdr dict)))))


