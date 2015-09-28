#! /usr/bin/env racket
; raco make $*
; raco exe  $*
; raco exe --gui $*
; lsof -n -i4TCP:8085
#lang racket/base
; (require db/base)
; (require db/postgresql)
(require racket/tcp
         racket/file
         racket/date
)
(provide serve)

(define log-file "main.log")
(define (timestamp)
  (string-append (number->string (date-year   (current-date))) "-"
                 (number->string (date-month  (current-date))) "-"
                 (number->string (date-day    (current-date))) " "
                 (number->string (date-hour   (current-date))) ":"
                 (number->string (date-minute (current-date))) ":"
                 (number->string (date-second (current-date)))
  )
)

(define (serve port-no)
  (define main-cust (make-custodian))
  (parameterize ([current-custodian main-cust])
    (define listener (tcp-listen port-no 5 #t))
    (if (tcp-listener? listener) (displayln "Listener OK")  (error "doesn't get here"))
    (define (loop)
      (accept-and-handle listener)
      (loop)
    )
    (void (thread loop))
  )
  (void (lambda ()
    (custodian-shutdown-all main-cust)
  ))
)

(define (accept-and-handle listener)
(display-to-file (string-append (timestamp) " Starting Thread" "\n") log-file #:mode 'text #:exists 'append)
  (define cust (make-custodian))
  (parameterize ([current-custodian cust])
    (define-values (in out) (tcp-accept listener))
    (void (thread (lambda ()
              (handle in out)
              (close-input-port in)
              (close-output-port out))))
  )
  ; Watcher thread:
  (void (thread (lambda ()
                  (sleep 10)
                  (custodian-shutdown-all cust)
                )
        )
  )
(display-to-file (string-append (timestamp) " Thread Ends" "\n") log-file #:mode 'text #:exists 'append)
)

(define (handle in out)
  ; Discard the request header (up to blank line):
  (regexp-match #rx"(\r\n|^)\r\n" in)
  ; Send reply:
  (display "HTTP/1.0 200 Okay\r\n" out)
  (display "Server: k\r\nContent-Type: text/html\r\n\r\n" out)
  (display "<html><body>Hello, world!</body></html>" out)
)
