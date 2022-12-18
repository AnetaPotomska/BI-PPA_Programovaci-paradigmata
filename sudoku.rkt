#lang racket
(require "resources.rkt")

; if num is is found in lst (representing row/col/square), return true, false otherwise
(define (is-in-list num lst)
  (cond [(null? lst) #f]
        [(equal? (car lst) num) #t]
        [else (is-in-list num (cdr lst))]))

; return positions representing side of square where n belongs
(define (get-positions n)
  (cond [(and (>= n 0) (<= n 2)) '(0 1 2)]
        [(and (>= n 3) (<= n 5)) '(3 4 5)]
        [(and (>= n 6) (<= n 8)) '(6 7 8)]
        [else '()]))

; get flatten square
(define (get-square row col lst)
  (let ([row-pos (get-positions row)] 
        [col-pos (get-positions col)]) 
    (for*/list ((i row-pos)(j col-pos))  
      (my-nth j (get-row i lst)))))

; if num is correctly placed based on rules of sudoku return true, false otherwise
(define (is-valid row col num lst)
  (let ([row-l (get-row row lst)]
        [col-l (get-col col lst)]
        [square-l (get-square row col lst)])
  (if (or (is-in-list num row-l) (is-in-list num col-l) (is-in-list num square-l))
      #f
      #t)))

; return nth element in lst
(define (my-nth n lst)
  (cond [(null? lst) null]
        [(= n 0) (car lst)]
        [else (my-nth (- n 1) (cdr lst))]))

; return element at coordinates row col
(define (get-element row col lst)
  (let ([tmp (get-row row lst)])
    (my-nth col tmp)))

; in lst1 replace num at position given by lst2
(define (replace-at-pos pos num lst)
  (append (take lst pos)
        (list num)
        (drop lst (+ pos 1))))
  
; insert num at position given by row and col in lst  
(define (insert-in row col num lst)
  (let* ([tmp (get-row row lst)]
        [new-row (replace-at-pos col num tmp)])
        (replace-at-pos row new-row lst)))

; return list representing column in lst at pos 
(define (get-col col lst)
  (map (lambda (row) (my-nth col row)) lst))

; return nth row in lst
(define (get-row row lst)
  (cond [(null? lst) lst]
        [(= row 0) (car lst)]
        [else (get-row (- row 1) (cdr lst))]))

; print outline
(define (my-outline)
  (display "+")
  (for ((i (range 0 17))) (display "-"))
  (display "+\n"))

; print solution in pretty way
(define (my-print lst)
  (for((row (range 0 9)))
    (when (equal? 0 (modulo row 3))
      (my-outline))
    (display "| ")
    (for((col (range 0 9)))
      (when (and (equal? 0 (modulo col 3)) (not (equal? col 0)))
        (display " | "))
      (print (get-element row col lst)))
    (display " |\n"))
  (my-outline))

; main function to go through every possibility until find solution
(define (loop row col lst)
  (cond [(= 0 (get-element row col lst))
         (for((i (range 1 10)))
           (when (is-valid row col i lst)
             (loop row col (insert-in row col i lst))))]
        [(< col 8)
         (loop row (+ 1 col) lst)]
        [(< row 8)
         (loop (+ 1 row) 0 lst)]
        [else (my-print lst)]))

; check if input sudoku has duplicates
(define (check-duplicate row col lst)
  (cond [(> row 8) #f]
        [(equal? col 9) (check-duplicate (+ row 1) 0 lst)]
        [else
         (let ([tmp (get-element row col lst)])
           (if (or
            (equal? tmp 0)
            (is-valid row col tmp (insert-in row col 0 lst)))
           (check-duplicate row (+ col 1) lst)
           #t))]))

; check if input sudoku is 9x9
(define (check-size i lst)
  (let ([row (flatten (get-row i lst))])
    (cond [(and (equal? i 9) (null? row)) #f]
          [(and (< i 9) (null? row)) #t]
          [(not (equal? 9 (length row))) #t]
          [else (check-size (+ i 1) lst)])))

; if sudoku can be solved show it, else print there is no solution
(define (get-solution lst)
  (cond [(check-size 0 lst)
         (display "Entered sudoku isn't 9x9, so it cannot be solved.") -2]
        [(check-duplicate 0 0 lst)
         (display "Entered sudoku has duplicates in it, so it cannot be solved.") -1]
        [else (loop 0 0 lst)]))

(provide (all-defined-out))
