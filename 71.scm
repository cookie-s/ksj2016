(define (_divide-list slist alist blist) ; divide slist to two lists whose size are about the same indunctively. ; TODO <- fix this word
  (if (null? slist) (cons (_divide-list alist '() '() ) (_divide-list blist '() '()))
    (if (null? (cdr slist)) slist
      (let ((a (car slist)) (b (if (null? (cdr slist)) '() (car (cdr slist)))))
        (let ((remain (if (null? b) (cdr slist) (cdr (cdr slist)))))
          (_divide-list remain (cons a alist) (if (null? b) blist (cons b blist))))))))

(define (_my-pair-sort alist blist res) ; alist and blist has to be sorted in advance.
  (if (null? alist) (if (null? blist) res (_my-pair-sort (cdr blist) '() res))
    (if (null? blist) (_my-pair-sort '() (cdr alist) (cons (car alist) res))
      (let ((a (car alist)) (b (car blist)))
        (if (string>? a b)
          (_my-pair-sort alist (cdr blist) (reverse (cons b (reverse res))))
          (_my-pair-sort (cdr alist) blist (reverse (cons a (reverse res)))))))))

(define (my-sort slist)
  (if (null? slist) slist
    (_my-sort 
