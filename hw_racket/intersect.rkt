#lang racket

;PRŮNIK NESEŘAZENÝCH SEZNAMŮ -------------------------------------
;Napište funkci intersect, která přijímá jako argument dva seznamy
;a vrací seznam, který bude obsahovat prvky, které se nacházejí
;v obou seznamech. Prvky v novém seznamu nebudou obsahovat duplicity
;a budou seřazené (výsledný seznam bude tedy reprezentovat seřazenou množinu).

;volající funkce
(define (intersect a b)
  (let* ([c (my-delete-duplicite (merge-sort a))]
        [d (my-delete-duplicite (merge-sort b))]
        [len-c (my-len c)]
        [len-d (my-len d)])
    (cond [(>= len-c len-d) (my-delete-duplicite (merge-sort (my-include-all-elems? d c '())))] ;pokud je d menší jde na pozici menšího seznamu ve volané funkci 
          [else (my-delete-duplicite (merge-sort (my-include-all-elems? c d '())))])))
; smaž duplicity
(define (my-delete-duplicite lst)
  (my-delete-duplicite-final lst null))
(define (my-delete-duplicite-final lst prev)
  (cond [(null? lst) lst]
        [(equal? (car lst) prev) (my-delete-duplicite-final (cdr lst) (car lst))]
        [else (cons (car lst) (my-delete-duplicite-final (cdr lst) (car lst)))]))
;rozpul seznam pomocná
(define (my-halves lst)
  (my-halves-final lst (/ (my-len lst) 2)))
;rozpul seznam konečná
(define (my-halves-final lst n)
  (if (<= n 0)
      (cons (null (cons lst null))) ; list není povolený
        (let ([subresult (my-halves-final (cdr lst) (- n 1))])
           (cons (cons (car lst) (car subresult)) (cdr subresult)))))
;merge sort
(define (merge-sort lst)
  (cond [(null? lst) lst] ;null actually
        [(null? (cdr lst)) lst] ;ten první
        [else (let* ([halved (my-halves lst)] ;halved je list dvou listů
              [first (car halved)]
              [second (cadr halved)]
              [first-sorted (merge-sort first)]
              [second-sorted (merge-sort second)])
                (merge first-sorted second-sorted))]))
;merge two lists          
(define (merge first second)
  (cond [(null? first) second]
        [(null? second) first]
        [(> (car first) (car second)) (cons (car second) (merge first (cdr second)))]
        [(< (car first) (car second)) (cons (car first) (merge (cdr first) second))]
        [else (cons (car first) (cons (car second) (merge (cdr first) (cdr second))))]))
;délka listu
(define (my-len lst)
  (if (null? lst)
      0
      (+ 1 (my-len (cdr lst)))))
;je element v listu?
(define (elem? val lst)
  (cond [(null? lst) #f]
        [(equal? val (car lst)) #t]
        [else (elem? val (cdr lst))]))
;jaké prvky ze small se překrývají s tím z big
;je logické, že záleží na tom jestli jedeme po seznamu kratším nebo delším
(define (my-include-all-elems? small big res)
  (cond [(null? small) res]
        [(null? big) '()]
        [(equal? (elem? (car small) big) #t) (my-include-all-elems? (cdr small) big (cons (car small) res))]
        [else (my-include-all-elems? (cdr small) big res)]))
