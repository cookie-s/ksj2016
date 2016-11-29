(load "75.scm")
(let ((t (btree-empty)))
  (define (input->string x)
    (cond
      ((symbol? x) (symbol->string x))
      ((number? x) (number->string x))
      ((string? x) x)
      (else #f)))
  (define (main-loop t)
    (let ((cmd (read)))
      (cond
        ((equal? cmd 'insert)
         (let* ((key (input->string (read)))
                (val (input->string (read))))
           (main-loop (btree-insert key val t))))
        ((equal? cmd 'delete)
         (let* ((key (input->string (read))))
           (main-loop (btree-delete key t))))
        ((equal? cmd 'search)
         (let* ((key (input->string (read)))
                (entry (btree-search key t)))
           (if (not entry)
             (display "(not found)\n")
             (begin
               (display (cdr entry))
               (newline)))
           (main-loop t)))
        ((or (equal? cmd 'quit) (eof-object? cmd))
         #t)
        (else
          (display "(unknown command)\n")
          (main-loop t)))))
  (main-loop t))

