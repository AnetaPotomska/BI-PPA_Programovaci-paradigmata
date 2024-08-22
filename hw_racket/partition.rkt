#lang racket

;PARTITION
;Napište funkci partition-by, která má jako parametr seznam
;s a unární predikát f (funkce jednoho parametru vracející #t nebo #f).
;Funkce partition-by vrátí seznam délky dva. První prvek tohoto seznamu
;bude seznam prvků, které splňují predikát f. Druhý prvek tohoto seznamu
;bude seznam prvků, které nesplňují predikát f. Relativní pořadí
;jednotlivých prvků bude nezměněné.

;volající funkce
(define (partition-by f s) ;s je seznam, f je predikát
  (cons (filter f s) (cons (foldl cons null (my-false (map f s) s '())) null))) ;fold otočí list z my-false
;jestli je to rovno false tak to vypiš
(define (my-false bool lst res)
  (cond [(null? bool) res]
        [(equal? (car bool) #f) (my-false (cdr bool) (cdr lst) (cons (car lst) res))]
        [else (my-false (cdr bool) (cdr lst) res)]
        ))
