; node: (cons (cons key value) (cons lnode rnode))

(define (btree-empty) (list))
(define (btree-null? t) (equal? t btree-empty))
(define (btree-insert key val t)
  (if (null? t) (cons (cons key val) (cons (btree-empty) (btree-empty)))
    (if (string<? key (car (car t)))
      (cons (car t) (cons (btree-insert key val (car (cdr t))) (cdr (cdr t))))
      (cons (car t) (cons (car (cdr t)) (btree-insert key val (cdr (cdr t))))))))

(define (btree-delete key t)
  (if (null? t) t
    (if (string=? key (car (car t)))
      (let ((minimum (letrec ((btree-find-minimum (lambda(t) (if (pair? (car (cdr t))) (btree-find-minimum (car (cdr t))) t)))) (btree-find-minimum t))))
        (cons (car minimum)


                               (if (string<? key (car (car t)))
                                 (cons (car t) (cons (btree-delete key val (car (cdr t))) (cdr (cdr t))))
                                 (cons (car t) (cons (car (cdr t)) (btree-delete key val (cdr (cdr t))))))))

                  (define (btree-search key t)
                    (if (null? t) #f
                      (if (string=? key (car (car t))) (cdr (car t))
                        (if (string<? key (car (car t)))
                          (btree-search key (car (cdr t)))
                          (btree-search key (cdr (cdr t)))))))
