#! /usr/bin/env racket
; raco make $*
; raco exe  $*
; raco exe --gui $*
; lsof -n -i4TCP:8085
#lang racket/base
; (require db/base)
; (require db/postgresql)
(require racket/tcp)
(provide serve)

(define (serve port-no)
  (define main-cust (make-custodian))
  (parameterize ([current-custodian main-cust])
    (define listener (tcp-listen port-no 5 #t))
    (define (loop)
      (accept-and-handle listener)
      (loop)
    )
;(displayln "Before thread")
    (thread loop)
;(displayln "After thread")
  )
  (lambda ()
    (custodian-shutdown-all main-cust)
  )
)

(define (accept-and-handle listener)
  (define cust (make-custodian))
  (parameterize ([current-custodian cust])
    (define-values (in out) (tcp-accept listener))
    (thread (lambda ()
              (handle in out)
              (close-input-port in)
              (close-output-port out))))
  ; Watcher thread:
  (thread (lambda ()
            (sleep 10)
            (custodian-shutdown-all cust)
          )
  )
)

(define (handle in out)
  ; Discard the request header (up to blank line):
  (regexp-match #rx"(\r\n|^)\r\n" in)
  ; Send reply:
  (display "HTTP/1.0 200 Okay\r\n" out)
  (display "Server: k\r\nContent-Type: text/html\r\n\r\n" out)
  (display "<html><body>Hello, world!</body></html>" out)
)