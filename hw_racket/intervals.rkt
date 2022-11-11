#lang racket

;INTERVALY ----------------------------------
;Napište funkci intervals, která přijímá seznam seznamů.
;Jednotlivé podseznamy mají vždy dva prvky, tedy například
;'( (1 5) (2 6) (0 1) (8 10) ). Každý tento podseznam reprezentuje intervaly.
;Například (1 5) reprezentuje interval od 1 do 5 včetně. Pro každý tento
;interval má funkce intervals vypočítat s kolika jinými intervaly se překrývá
;(průnik intervalu se sebou samým se nepočítá). Intervaly jsou vždy zadány vzestupně.

;volající funkce
(define (intervals lst)
  (my-intervals lst lst '()))
(define (my-intervals a b res)
  (cond [(null? b) (foldl cons null res)]
        [else (my-intervals a (cdr b) (cons (my-calc (car b) a -1) res))]))
(define (my-calc one rest result)
  (cond [(null? rest) result]
        [(and (<= (car one) (caar rest)) (<= (caar rest) (cadr one))) (my-calc one (cdr rest) (+ 1 result))]
        [(and (<= (caar rest) (car one)) (<= (car one) (cadar rest))) (my-calc one (cdr rest) (+ 1 result))]
        [else (my-calc one (cdr rest) result)]))

