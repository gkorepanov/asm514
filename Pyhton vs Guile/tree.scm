(define (max a b) (if (> a b) a b))
(define (_l node) (car node))
(define (_key node) (cadr node))
(define (_h node) (if (null? node) 0 (caddr node)))
(define (_r node) (cadddr node))
(define (balance node) 
    (if (null? node) 
        0 
        (- (_h (_l node)) (_h (_r node))))
)

(define (new_height l r) (+ 1 (max (_h l) (_h r))))


(define (lrotate node)
    (let* 
        (
            (r (_r node))
            (rl (_l r))
            (rr (_r r))
            (l (list (_l node) (_key node) (new_height (_l node) rl) rl))
        )
        (list l (_key r) (new_height (_l node) rr) rr)
    )
)

(define (rrotate node)
    (let* 
        (
            (l (_l node))
            (lr (_r l))
            (ll (_l l))
            (r (list lr (_key node) (new_height (_r node) lr) (_r node)))
        )
        (list ll (_key l) (new_height (_r node) ll) r)
    )
)

(define (rebalance node)
    (let ((bal (balance node)))
        (cond 
            ((= bal 2)  (rrotate (let ((l (if (< (balance (_l node)) 0) (lrotate (_l node)) (_l node))))
                        (list
                           l
                           (_key node)
                           (new_height l (_r node))
                           (_r node)
                        )))
            )

            ((= bal -2) (lrotate (let ((r (if (> (balance (_r node)) 0) (rrotate (_r node)) (_r node))))
                        (list
                           (_l node)
                           (_key node)
                           (new_height r (_l node))
                           r
                        )))
            )
            (else node)
        )
    )
)
                        

(define (tree_insert node x) 
    (if (null? node)
        (list '() x 1 '())
        (cond 
         ((> x (_key node))
            (let ((r (tree_insert (_r node) x)))
                (rebalance (list (_l node) (_key node) (new_height r (_l node)) r))))
         ((< x (_key node))
            (let ((l (tree_insert (_l node) x)))
                (rebalance (list l (_key node) (new_height l (_r node)) (_r node)))))
         (else node)
        )
    )
)

(define (print_tabs n) 
    (cond ((not (= n 0)) 
        (begin 
            (display "\t")
            (print_tabs (- n 1))
        ))
    )
)

(define (show node level) 
    (cond ((not (null? node))
        (begin 
            (cond ((not (null? (_r node)))
                (begin
                    (show (_r node) (+ 1 level))
                    (display (make-string level #\tab))
                    (display "      /")
                    (newline)
                ))
            )

            (display (make-string level #\tab))
            (display (_key node))
            (newline)

            (cond ((not (null? (_l node)))
                (begin
                    (display (make-string level #\tab))
                    (display "      \\")
                    (newline)
                    (show (_l node) (+ 1 level))
                ))
            )      
        )
    ))
)
 
                
(let ((time (gettimeofday)))
       (set! *random-state*
             (seed->random-state (+ (car time)
                                    (cdr time)))))

(define (insert_numbers n range)
  (letrec ((_insert (lambda (t k)
     (if (= k 0) t
      (_insert (tree_insert t (random range)) (- k 1))))))
    (_insert '() n)))

(show (insert_numbers (read) 10000000) 0)
