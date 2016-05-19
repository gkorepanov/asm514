;       1) Had to create a generator maker.
;       2)  For each func the yeild is unique, so
;           the func should be aware of its yield
;           so I have to pass yield to function as an arg. (#0)

(define (make_gen func)
    ; current stack state. Initially it's just a func itself:
    (define *env* (lambda () (func yield)))
    ; "function" which returns a value to external code
    (define *return* #f) ;  

    (define (yield x)
        (call/cc 
            (lambda (ret)
                (begin
                    (set! *env* ret) ; save the state
                    (*return* x) ; return value
                )
            )
        )
    )
    
    ; the core:
    (lambda calculate 
        (call/cc 
            (lambda (ret)
                ; here we save the env which will return value to 
                ; external code in case yield adress it

                (set! *return* ret)
                (*env*) ; call next iteration
            )
        )
    )
)


; an example of use, just simple sequence generator

(define (seq n)
    (lambda (yield) ; that is what embarassing me (#0)
        (begin
        (letrec ((nextval 
                        (lambda (n)
                            (begin 
                                (yield n) ; that is how yield is used
                                (nextval (- n 1))
                            )
                        )))
         (nextval n))
    ))
)


(define myseq (make_gen (seq 10))) ; creating the definite gen

(letrec ((call_gen (lambda (n) 
                    (cond (
                        (> n 0)
                        (begin
                            (display (myseq))
                            (display " ")
                            (call_gen (- n 1))
                        )
                    )))))
          (call_gen 100))
(newline)   
