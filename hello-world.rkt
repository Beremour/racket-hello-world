#! /usr/bin/env racket
; raco make $*
; raco exe  $*
; raco exe --gui $*
#lang racket/base
(require db/base)
(require db/postgresql)

(require "hello-world-mod1.rkt" "hello-world-mod2.rkt")
(+ b c)
(* b c)
(+ b c b c b)
(display "\u03BB")
(newline)
(>= 4 5 )
(>= (+ 4 (random)) 9 )
(display "Is equal?: ")
(equal? 4 4)
(number->string 255 16)

(define pgc
  (postgresql-connect #:user "wbowner"
                      #:database "wbank"
                      #:password "owner")
)

(define cursor-accounts
  (prepare pgc "select acc,open_date from gl_acct where acc > $1")
)

;(for ((
;(acc open-date) (in-query pgc cursor-accounts 777)
;     ))
;  (printf "~a: ~a:\n" acc open-date)
;)
(for ((
(acc open-date) (in-query pgc (bind-prepared-statement cursor-accounts '(4702810300000000937))  )
     ))
  (printf "~a: ~a:\n" acc open-date)
)

(disconnect pgc)
