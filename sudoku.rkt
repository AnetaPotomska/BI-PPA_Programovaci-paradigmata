#lang racket
(require "resources.rkt")

; if num is is found in lst (representing row/col/square), return true, false otherwise
(define (is-in-list lst num)
  (cond [(null? lst) #f]
        [(equal? (car lst) num) #t]
        [else (is-in-list (cdr lst) num)]))

; return positions representing side of square where n belongs
(define (get-positions n)
  (cond [(and (>= n 0) (<= n 2)) '(0 1 2)]
        [(and (>= n 3) (<= n 5)) '(3 4 5)]
        [(and (>= n 6) (<= n 8)) '(6 7 8)]))

; get flatten square
(define (get-square row col lst)
  (let ([row-pos (get-positions row)] 
        [col-pos (get-positions col)]) 
    (for*/list ((i row-pos)(j col-pos))  
      (my-nth (get-row lst i) j))))

; if num is correctly placed based on rules of sudoku return true, false otherwise
(define (is-valid row col num lst)
  (let ([row-l (get-row lst row)]
        [col-l (get-col lst col)]
        [square-l (get-square row col lst)])
  (if (or (is-in-list row-l num) (is-in-list col-l num) (is-in-list square-l num))
      #f
      #t)))

; return nth element in lst
(define (my-nth lst n)
  (cond [(null? lst) null]
        [(= n 0) (car lst)]
        [else (my-nth (cdr lst) (- n 1))]))

; return nth row in lst
(define (get-row lst row)
  (cond [(= row 0) (car lst)]
        [else (get-row (cdr lst) (- row 1))]))

; return element at coordinates row col
(define (get-element row col lst)
  (let ([tmp (get-row lst row)])
    (my-nth tmp col)))

; if it finds 0 - it return list row col where 0 is, otherwise list -1 -1
(define (find-first-zero row col lst)
  (if (or (> row 8) (> col 8) (< row 0) (< col 0))
      '(-1 -1)
      (let* ([tmp (get-row lst row)]
             [nth (my-nth tmp col)])
        (cond [(null? tmp) '(-1 -1)]
              [(equal? nth 0) `(,row ,col)]
              [(equal? row 9) '(-1 -1)]
              [(equal? col 9) (find-first-zero (+ row 1) 0 lst)]
              [else (find-first-zero row (+ col 1) lst)]))))

; in lst1 replace num at position given by lst2
(define (replace-at-pos lst1 lst2 num)
  (append (take lst1 lst2)
        (list num)
        (drop lst1 (+ lst2 1))))
  
; insert num at position given by row and col in lst  
(define (insert-in row col num lst)
  (let* ([tmp (get-row lst row)]
        [new-row (replace-at-pos tmp col num)])
        (replace-at-pos lst row new-row)))

; return list representing collumn in lst at pos 
(define (get-col lst pos)
  (map (lambda (row) (my-nth row pos)) lst))

; check if input sudoku is correct
(define (check-correctness row col lst)
  (if (or (> row 8) (> col 8))
      #t
      (let* ([tmp (get-row lst row)]
             [nth (my-nth tmp col)])
        (cond [(equal? col 9) (check-correctness (+ row 1) 0 lst lst)]
              [else
               (cond [(equal? nth 0) (check-correctness row (+ col 1) lst)]
                     [(is-valid row col nth (insert-in row col 0 lst)) (check-correctness row (+ col 1) lst)]
                     [else #f])]))))

; if sudoku can be solved returnes this solution, null otherwise
(define (solve-sudoku lst num next)
  (cond [(and (equal? (car next) -1) (equal? (cadr next) -1)) lst]
        [(and (> num 9) (> (car next) -1) (> (cadr next) -1)) (solve-sudoku lst 1 next)]
        [(> num 9) null]
        [(is-valid (car next) (cadr next) num lst) (let ([retVal (insert-in (car next) (cadr next) num lst)]) (solve-sudoku retVal 1 (find-first-zero 0 0 retVal)))]
        [(not (is-valid (car next) (cadr next) num lst)) (solve-sudoku lst (+ num 1) next)]) null)
             

; if sudoku can be solved show it, else print there is no solution
(define (get-solution lst)
  (cond [(not (check-correctness 0 0 lst)) (println "Entered sudoku has mistakes in it, so it cannot be solved.") -1]
        [else
         (let ([tmp (solve-sudoku lst 1 (find-first-zero 0 0 lst))])
         (cond [(null? tmp) (println "Program couldn't find any solution.") -2]
               [else tmp]))]))


(provide (all-defined-out))