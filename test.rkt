#lang racket
(require "resources.rkt")
(require rackunit)
(require "sudoku.rkt")

(check-equal? (is-in-list 5 '(1 2 3 4 0 6 7 8 9)) #f)
(check-equal? (is-in-list 4 '(1 2 3 4 0 6 7 8 9)) #t)
