#lang racket

;NÁSOBENÍ MATIC --------------------------------------------
;Napište funkci matrix-mul, která dostane na vstupu dvě matice a provede
;maticový součin. Matice je reprezentována jako seznam jednotlivých řádků.
;Můžete se spolehnout, že matice budou vždy mít korektní rozměry a vždy budou
;mít alespoň jeden řádek a sloupec.

;volající funkce
(define (matrix-mul a b)
  (matrix-mul-final a b '()))
;finální
(define (matrix-mul-final a b res)
  (let ([t (my-transpose b)])
  (cond [(null? a) (my-transpose res)]
         [else (matrix-mul-final (cdr a) b (cons (my-mul (car a) t '()) res))])))
;udělej transpozici matice
(define (my-transpose a)
  (my-tr-final a (my-len (car a)) 0 '())
  )
;délka listu
(define (my-len a)
  (if (null? a)
      0
      (+ 1 (my-len (cdr a)))))
;finální pro transpozici
(define (my-tr-final a len pos res)
  (cond [(equal? len pos) res]
        [else (my-tr-final a len (+ pos 1) (cons (my-col a pos) res))]))
;n-tý prvek
(define (my-nth a pos)
  (cond [(null? a) null]
        [(equal? pos 0) (car a)]
        [else (my-nth (cdr a) (- pos 1))]))
;n-tý sloupec
(define (my-col a pos)
  (map (lambda (row) (my-nth row pos)) a))
;vytvoř seznam pro násobení první řádky a se všemi z t
(define (my-mul a b res)
  (cond [(null? b) res]
         [else (my-mul a (cdr b) (cons (my-sum a (car b) 0) res))]))
;vynásob prvky na stejných pozicích a sečti
(define (my-sum a b res)
  (cond [(null? a) res]
        [(null? b) res]
         [else (my-sum (cdr a) (cdr b) (+ (* (car a) (car b)) res))]))
         
         
;(1 2 3)
;(4 1 1)

;*

;(1 2)     transpozice
;(3 4) ->  (1 3 2)
;(2 1)     (2 4 1)

;=

;(1*1+2*3+3*2 1*2+2*4+3*1)
;(4*1+1*3+1*2 4*2+1*4+1*1)

;=

;(13 13)
;(9 13)
