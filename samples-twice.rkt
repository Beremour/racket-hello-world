#lang racket/base

(define (twice f v)
  (f (f v))
)

(define (make-add-suffix s2)
  (lambda (s) (string-append s s2))
)

(twice (make-add-suffix "!") "hello")
