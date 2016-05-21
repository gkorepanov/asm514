(define left cadr)
(define right caddr)
(define key car)
(define height cadddr)
;(define height cadr)

(define (balance tree)
 (if (null? tree) 0
  (- (get_height (left tree))  (get_height (right tree)))))

(define (h_ tree)
 (if (null? tree) 0
  (height tree)))
 
(define (get_height tree)
 (if (null? tree) 0
  (+ 1 (max (h_ (left tree)) (h_ (right tree))))))

(define (lrotate tree)
  (list (key (left tree)) 
   (left (left tree))
   (list (key tree) (right (left tree)) (right tree) (get_height tree)) 
   (get_height (left tree))))

(define (rrotate tree)
 (list (key (right tree)) ;maybe error
  (list (key tree) (left tree) (left (right tree)) (get_height tree))
  (right (right tree)) (get_height (right tree))))

(define (lbrotate tree)
 (lrotate (list (key tree) (rrotate (left tree)) (right tree) (get_height tree))))

(define (rbrotate tree)
 (rrotate (list (key tree) (left tree) (lrotate (right tree)) (get_height tree))))

(define (insert element tree)
 (cond 
  [(null? tree)
   (list element '() '() 1)]
  [(< element (key tree))
   (let
    ((temp (list (key tree) (insert element (left tree)) (right tree) (+ 1 (get_height tree)))))
    ;(display tree)
    ;(display "\n")
    (when (= 2 (balance temp)) ;balance factor
     (if (< element (key (left temp)))
      (set! temp (lrotate temp))
      (set! temp (lbrotate temp))))
    temp)]
  [(> element (key tree))
   (let
    ((temp (list (key tree) (left tree) (insert element (right tree)) (+ 1 (get_height tree)))))
    (when (= -2 (balance temp)) ;balance factor
     (if (> element (key (right temp)))
      (set! temp (rrotate temp))
      (set! temp (rbrotate temp))))
    temp)]
 (else tree)))

(define (print_tree tree level)
 (if (not (equal? '() (right tree)))
  (begin (print_tree (right tree) (+ level 1))
   (display (make-string (* 4 level) #\ ))
   (display "    /\n")))
 (display (make-string (* 4 level) #\ ))
 (display (key tree))
 (display "\n")
 (if (not (equal? '() (left tree)))
  (begin (display (make-string (* 4 level) #\ ))
   (display "    \\\n")
   (print_tree (left tree) (+ level 1)))))


(define (insert_num n tree)
 (if (> n 0)
  (begin (set! tree (insert (random 99) tree))
   (insert_num (- n 1) tree))))

(define tree '())
(insert_num 10000 tree)
(set! tree (insert 15 tree))
(set! tree (insert 20 tree))
(set! tree (insert 25 tree))
(set! tree (insert 35 tree))
;(display tree)
