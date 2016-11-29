; node: (cons (cons key value) (cons lnode rnode))

(define (btree-ltree t) (car (cdr t)))
(define (btree-rtree t) (cdr (cdr t)))
(define (btree-node t) (car t))
(define (node-key n) (car n))
(define (node-value n) (cdr n))

(define (btree-empty) (list))
(define (btree-null? t) (equal? t (btree-empty)))
(define (btree-insert key val t)
  (cond
    ((null? t) (cons (cons key val) (cons (btree-empty) (btree-empty))))
    ((string=? key (node-key (btree-node t))) (cons (cons key val) (cons (btree-ltree t) (btree-rtree t))))
    ((string<? key (node-key (btree-node t))) (cons (btree-node t) (cons (btree-insert key val (btree-ltree t)) (btree-rtree t))))
    (else (cons (btree-node t) (cons (btree-ltree t) (btree-insert key val (btree-rtree t)))))))

(define (_find-minimum t)
  (if (btree-null? t) t
    (if (btree-null? (btree-ltree t)) (cons (btree-node t) (btree-rtree t))
      (let ((minimum (_find-minimum (btree-ltree t))))
        (cons (car minimum) (cons (btree-node t) (cons (cdr minimum) (btree-rtree t))))))))

(define (btree-delete key t)
  (cond
    ((null? t) t)
    ((string=? key (node-key (btree-node t)))
     (let ((minimum (_find-minimum (btree-rtree t))))
       (cons (car minimum) (cons (btree-ltree t) (cdr minimum)))))
    ((string<? key (car (car t))) (cons (car t) (cons (btree-delete key (car (cdr t))) (cdr (cdr t)))))
    (else (cons (car t) (cons (car (cdr t)) (btree-delete key (cdr (cdr t))))))))

(define (btree-search key t)
  (cond
    ((null? t) #f)
    ((string=? key (node-key (btree-node t))) (btree-node t))
    ((string<? key (node-key (btree-node t))) (btree-search key (btree-ltree t)))
    (else (btree-search key (btree-rtree t)))))
