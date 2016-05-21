; You'd better to use some ideas from (define-syntax)
; or use a (match) expression:

(define left cadr)
(define right caddr)
(define key car)
(define height cadddr)

; Too many globally useless checks of null-ness.
; If you know your object is null, no need to know its balance.
(define (balance tree)
 (if (null? tree) 0
  (- (get_height (left tree))  (get_height (right tree)))))

; why duplcating the function?
(define (h_ tree)
 (if (null? tree) 0
  (height tree)))
 
(define (get_height tree)
 (if (null? tree) 0
  (+ 1 (max (h_ (left tree)) (h_ (right tree))))))


; roating functions look pretty well but why to use get_height here?
; you are not updating the heights here.
; BTW, it would be a good idea to implement updating heights right here, it would
; contract your code twice.
(define (lrotate tree)
  (list (key (left tree)) 
   (left (left tree))
   (list (key tree) (right (left tree)) (right tree) (get_height tree)) 
   (get_height (left tree))))

(define (rrotate tree)
 (list (key (right tree))
  (list (key tree) (left tree) (left (right tree)) (get_height tree))
  (right (right tree)) (get_height (right tree))))

(define (lbrotate tree)
 (lrotate (list (key tree) (rrotate (left tree)) (right tree) (get_height tree))))

(define (rbrotate tree)
 (rrotate (list (key tree) (left tree) (lrotate (right tree)) (get_height tree))))

; your main problem is that you are messing set! with pure fucntional code.
; It makes your code incomprehensible and eliminates all the advances functional
; style gives you.
(define (insert element tree)
 (cond 
  [(null? tree)
   (list element '() '() 1)]

  [(< element (key tree))
   (let
    ((temp (list (key tree) (insert element (left tree)) (right tree) (+ 1 (get_height tree)))))
    (if (= 2 (balance temp)) ;balance factor
     ; here is a plain the example how could you get rid of set!
     (if (< element (key (left temp)))
      (lrotate temp)
      (lbrotate temp))
     temp))]
    ; end of example 

  [(> element (key tree))
   (let
    ((temp (list (key tree) (left tree) (insert element (right tree)) (+ 1 (get_height tree)))))
    (when (= -2 (balance temp)) ;balance factor
     (if (> element (key (right temp)))
      (set! temp (rrotate temp))
      (set! temp (rbrotate temp))))
    temp)]
 (else tree)))

; I suggest finding out about
; eq, eqv, equal and =
(define (print_tree tree level)
 (if (not (null? (right tree)))
  (begin (print_tree (right tree) (+ level 1))
   (display (make-string (* 8 level) #\ ))
   (display "       /\n")))
 (display (make-string (* 8 level) #\ ))
 (display (key tree))
 (display "\n")
 (if (not (null? (left tree)))
  (begin (display (make-string (* 8 level) #\ ))
   (display "       \\\n")
   (print_tree (left tree) (+ level 1)))))



; I couldn't understand what was here. I've just replaced it with:
(define (insert_num n)
 (letrec ((_loop (lambda (res k) 
        (if (= k 0)
            res
            (_loop (insert (random 10000000) res) (- k 1))
        ))))
  (_loop '() n))
 )

; there is no even a fake random. You have to initialize generator to get diffrent result.
(print_tree (insert_num 27) 0)
