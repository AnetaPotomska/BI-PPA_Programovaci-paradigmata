#lang racket
(require "resources.rkt")
(require rackunit)
(require "sudoku.rkt")

(check-equal? (is-in-list '(1 2 3 4 0 6 7 8 9) 5) #f)
(check-equal? (is-in-list '(1 2 3 4 0 6 7 8 9) 4) #t)
(check-equal? (get-solution test2) -1)
(check-equal? (get-solution test3) -1)
;(assert-equal (get-solution test4) test4-res)
