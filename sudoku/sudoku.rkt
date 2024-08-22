#lang racket
(require "resources.rkt")

; if num is is found in lst (representing row/col/square), return true, false otherwise
(define (is-in-list num lst)
  (cond [(null? lst) #f]
        [(equal? (car lst) num) #t]
        [else (is-in-list num (cdr lst))]))

; main function for creating helper list
(define (create-help-list n m l k lst)
  (cond [(equal? n 0) (foldl cons null lst)]
        [else (create-help-list (- n k) (+ m k) (+ l k) k (cons (range m l) lst))]))

; create list, for example:
; - for input 9 creates '((0 1 2) (3 4 5) (6 7 8))
; - for input 4 creates '((0 1) (2 3))
(define (create-help-list-caller n)
  (create-help-list n 0 (sqrt n) (sqrt n) '()))

; get flatten square
(define (get-square row col helper lst)
  (let* ([row-pos (flatten (filter (λ (x) (member row x)) helper))] 
        [col-pos (flatten (filter (λ (x) (member col x)) helper))]) 
    (for*/list ((i row-pos)(j col-pos))  
      (my-nth j (get-row i lst)))))

; if num is correctly placed based on rules of sudoku return true, false otherwise
(define (is-valid num row-l col-l square-l)
  (not (or (is-in-list num row-l) (is-in-list num col-l) (is-in-list num square-l))))

; return nth element in lst
(define (my-nth n lst)
  (cond [(null? lst) null]
        [(= n 0) (car lst)]
        [else (my-nth (- n 1) (cdr lst))]))

; return element at coordinates row col
(define (get-element row col lst)
  (let ([tmp (get-row row lst)])
    (my-nth col tmp)))

; in lst replace num at position given by pos
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
(define (my-outline max)
  (display "+")
  (for ((i (range 0 max))) (display "-"))
  (display "+\n"))

; print solution in pretty way
(define (my-print size lst)
  (let ([line (* 3 size)])
  (for((row (range 0 size)))
    (when (equal? 0 (modulo row (sqrt size)))
      (my-outline line))
    (display "| ")
    (for((col (range 0 size)))
      (when (and (equal? 0 (modulo col (sqrt size))) (not (equal? col 0)))
        (display "| "))
      (print (get-element row col lst))
      (display " "))
    (display "|\n"))
  (my-outline line)))

; main function to go through every possibility until find solution
(define (loop row col size helper lst)
  (cond [(= 0 (get-element row col lst))
         (let ([row-l (get-row row lst)]
               [col-l (get-col col lst)]
               [square-l (get-square row col helper lst)])
         (for((i (range 1 (+ size 1))))
           (when (is-valid i row-l col-l square-l)
             (loop row col size helper (insert-in row col i lst)))))]
        [(< col (- size 1))
         (loop row (+ 1 col) size helper lst)]
        [(< row (- size 1))
         (loop (+ 1 row) 0 size helper lst)]
        [else (my-print size lst)]))

; check if input sudoku has duplicates and that numbers are in range 0 to size
(define (check-correctness row col size helper lst)
  (cond [(> row (- size 1)) #f]
        [(equal? col size) (check-correctness (+ row 1) 0 size helper lst)]
        [else
         (let* ([tmp (get-element row col lst)]
               [el (insert-in row col 0 lst)]
               [row-l (get-row row el)]
               [col-l (get-col col el)]
               [square-l (get-square row col helper el)])
           (cond [(or (> tmp size) (< tmp 0)) #t]
                 [(or
                   (equal? tmp 0)
                   (is-valid tmp row-l col-l square-l))
                  (check-correctness row (+ col 1) size helper lst)]
                 [else #t]))]))


; check if input sudoku is n2^2 * n^2
(define (check-size i size lst)
  (let ([row (flatten (get-row i lst))])
    (cond [(and (equal? i size) (null? row)) #f]
          [(and (< i size) (null? row)) #t]
          [(not (equal? size (length row))) #t]
          [else (check-size (+ i 1) size lst)])))


; if sudoku can be solved show it, else print there is no solution
(define (get-solution lst)
  (let* ([size (length (car lst))]
         [helper (create-help-list-caller size)])
  (cond [(check-size 0 size lst)
         (display "Entered sudoku isn't n^2 * n^2, so it cannot be solved.") -2]
        [(check-correctness 0 0 size helper lst)
         (display "Entered sudoku has mistakes in it, so it cannot be solved.") -1]
        [else (loop 0 0 size helper lst)])))

(provide (all-defined-out))
