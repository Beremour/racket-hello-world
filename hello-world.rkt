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
  (postgresql-connect #:user      "wbowner"
                      #:database  "wbank"
                      #:password  "owner"
                      #:server    "api"
                      #:port       5432
  )
)

(define cursor-accounts
  (prepare pgc "select acc,open_date from gl_acct where acc > $1")
)
(define acc-mask 4702810300000000937)

(for ((
(acc open-date) (in-query pgc cursor-accounts acc-mask)
     ))
  (printf "~a: ~a:\n" acc open-date)
)

(let acc-mask 4702810300000000938)

(for ((
(acc open-date) (in-query pgc cursor-accounts acc-mask)
     ))
  (printf "~a: ~a:\n" acc open-date)
)

(disconnect pgc)

(module+ test
  (require rackunit)
  (check-equal? 1 1)
)
