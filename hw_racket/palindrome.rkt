#lang racket

;PALINDROM ----------------------------------------------
;Napište funkci is-palindrome?, který zjistí, zdali je seznam,
;kromě prvního a posledního prvku, palindromem.
;Vizte příklady. Pro seznamy délky 0, 1 rovnou vraťte #t.

;volající funkce
(define (is-palindrome? lst)
  (cond [(null? lst) #t]
        [(null? (cdr lst)) #t]
        [else (is-palindrome-final (my-crop lst))] 
        ))
;uřízni první a poslední prvek
(define (my-crop lst)
  (foldl cons null (cdr (foldl cons null (cdr lst)))))
;upravený seznam bez prvního a posledního prvku
(define (is-palindrome-final lst)
  (cond [(null? lst) #t]
        [(null? (cdr lst)) #t]
        [(not (equal? (car lst) (car (foldl cons null lst)))) #f]
        [else (is-palindrome-final (my-crop lst))]
        ))
