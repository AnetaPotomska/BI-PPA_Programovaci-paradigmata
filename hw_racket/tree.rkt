#lang racket

;VYVÁŽENÍ STROMU ---------------------------------------------------
;Napište funkci is-balanced?, která přijímá jako argument binární strom
;a vrátí #t pokud je strom vyvážený, v opačném případě vrátí #f.
;Strom považujeme za vyvážený, pokud pro každý jeho vrchol platí,
;že se výšky jeho podstromů neliší o více než 1.

;Binární strom je reprezentován jako prázdný seznam, nebo jako seznam o
;třech prvcích (hodnota_ve_vrcholu levy_podstrom pravy_podstrom).

;volající funkce
(define (is-balanced? lst)
  (if (null? lst) ;basic case
      #t
  (let ([left-branch (left! lst)] ;ať to nemusím pořád psát
        [right-branch (right! lst)] ;ať to nemusím pořád psát
        )
  (cond [(and (not (null? left-branch)) (not (null? right-branch))) (and (<= (- (bst-height left-branch) (bst-height right-branch)) 1) (is-balanced? left-branch) (is-balanced? right-branch))] ;pokud ani jedna ze subvětví není null, tak odečtem jejich délky a porovnáme, dále musíme jít dál - vše musí být true
        [(null? left-branch) (<= (bst-height right-branch) 1)] ;pokud je jedna ze subvětví null tak o vybalancování záleží na délce druhé subvětve
        [else (<= (bst-height left-branch) 1)]))))
;vrať max z daných prvků
(define (my-max x y)
  (if (> x y)
      x
      y))
;jdi doleva '(_ L _)
(define (left! bst)
  (cadr bst)) ; (car(cdr bst))
;jdi doprava '(_ _ R)
(define (right! bst)
  (caddr bst)) ; (car(cdr(cdr bst)))
;spočte výšku stromu
(define (bst-height bst)
  (if (null? bst)
      0
      (+ 1 (my-max (bst-height (left! bst)) (bst-height (right! bst))))))

