#! /usr/bin/env racket
; raco make $*
; raco exe  $*
; raco exe --gui $*
#lang racket/base
(require "hello-world-mod1.rkt" "hello-world-mod2.rkt")
(+ b c)
(+ b c b c b)
(display "\u03BB")
(newline)
(>= 4 5 )
(>= (+ 4 (random)) 9 )
(display "Is equal?: ")
(equal? 4 4)
(number->string 255 16)
