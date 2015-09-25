#! /usr/bin/env racket
; raco make $*
; raco exe  $*
; raco exe --gui $*
#lang racket/base
(require "tcp-listener.rkt")

(serve 8085)