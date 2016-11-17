(define (_sort-two-sorted-list alist blist res)
 (if (null? alist) (if (null? blist) res (_sort-two-sorted-list blist alist res))
  (if (null? blist) (_sort-two-sorted-list (cdr alist) '() (reverse (cons (car alist) (reverse res))))
   (let ((a (car alist)) (b (car blist)))
        (if (string>? a b)
          (_sort-two-sorted-list alist (cdr blist) (reverse (cons b (reverse res))))
          (_sort-two-sorted-list (cdr alist) blist (reverse (cons a (reverse res)))))))))

(define (_divide-list slist alist blist)
  (if (null? slist) (cons (reverse alist) (reverse blist))
    (let ((a (car slist)) (b (if (null? (cdr slist)) '() (car (cdr slist)))))
      (_divide-list (if (null? b) '() (cdr (cdr slist))) (cons a alist) (if (null? b) blist (cons b blist))))))

(define (my-sort slist)
  (if (null? (cdr slist)) slist
    (let ((divided-list (_divide-list slist '() '())))
      (_sort-two-sorted-list (my-sort (car divided-list)) (my-sort (cdr divided-list)) '() ))))
