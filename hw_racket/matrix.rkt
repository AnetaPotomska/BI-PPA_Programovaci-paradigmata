#lang racket

;NÁSOBENÍ MATIC --------------------------------------------
;Napište funkci matrix-mul, která dostane na vstupu dvě matice a provede
;maticový součin. Matice je reprezentována jako seznam jednotlivých řádků.
;Můžete se spolehnout, že matice budou vždy mít korektní rozměry a vždy budou
;mít alespoň jeden řádek a sloupec.

;udělej transpozici matice
(define (my-transpose a)
  (my-tr-final a (my-len (car a)) '()))
;délka listu
(define (my-len a)
  (if (null? a)
      -1
      (+ 1 (my-len (cdr a)))))
;finální pro transpozici
(define (my-tr-final a len res)
  (cond [(equal? len -1) res]
        [else (my-tr-final a (- len 1) (cons (my-col a len) res))]))
;n-tý prvek
(define (my-nth a pos)
  (cond [(null? a) null]
        [(equal? pos 0) (car a)]
        [else (my-nth (cdr a) (- pos 1))]))
;n-tý sloupec
(define (my-col a pos)
  (map (lambda (row) (my-nth row pos)) a))

;volající funkce
(define (matrix-mul a b)
  (foldl cons null (matrix-mul-final a (my-transpose b) '())))
;finální
(define (matrix-mul-final a b res)
  (cond [(null? a) res] 
         [else (matrix-mul-final (cdr a) b (cons (my-mul (car a) b '()) res))]))
;vytvoř seznam pro násobení první řádky a se všemi z t
(define (my-mul a b res)
  (cond [(null? b) (foldl cons null res)]
         [else (my-mul a (cdr b) (cons (my-sum a (car b) 0) res))]))
;vynásob prvky na stejných pozicích a sečti
(define (my-sum a b res)
  (cond [(null? a) res]
        [(null? b) res]
         [else (my-sum (cdr a) (cdr b) (+ (* (car a) (car b)) res))]))
