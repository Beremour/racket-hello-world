#lang racket
; (require racket/tcp)

; An echo server
(define listener (tcp-listen 12345))

(let echo-server ()
  (define-values (in out) (tcp-accept listener))
  (thread (lambda () (display "thread start")
                     (copy-port in out)
                     (close-output-port out)))
                     (display "thread end")
  (echo-server)
)
