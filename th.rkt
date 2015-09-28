#lang racket/base

(thread (lambda ()
          (for ([i 10])
            (sleep 2)
            (printf "thread 1\n"))))

(thread (lambda ()
          (for ([i 20])
            (sleep 1)
            (printf "thread 2\n"))))

(sleep 25)
