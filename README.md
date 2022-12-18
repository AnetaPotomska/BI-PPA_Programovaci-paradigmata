# Sudoku solver

## Zadání
Napište sudoku solver. Na vstupu dostanete hrací desku s libovolným počtem předvyplněných buněk. Vaším úkolem je vyplnit Sudoku, pokud řešení existuje.

### Minimální požadavky
Vaše aplikace musí umět alespoň:

Interně zareprezentovat sudoku (načítat ze vstupu nemusíte, stačí sudoku předat funkci ve formě matice)
Najít alespoň jedno řešení (existuje-li) libovolně zadaného sudoku 9x9.

### Bodování
Funkční řešení splňující minimální požadavky bude hodnoceno v rozmezí 5 až 10 bodů. Extra body jsou za následující rozšíření:

* Velikost hrací desky není omezená.

## Vlastnosti aplikace
* napsaná v racketu
* samotná aplikace se nachází v souboru [sudoku.rkt](sudoku.rkt)
* umí zpracovat jen sudoku o velikosti 9x9
* umí zkontrolovat vstupní sudoku
  * zkontroluje zda je skutečně 9x9
  * zkontroluje zda nejsou v sudoku žádné duplikáty
* pokud je vstupní sudoku v pořádku najde všechna jeho řešení
* umí vypsat řešení v hezkém formátu
* každá funkce je v kódu v krátkosti popsaná
* v souboru [test.rkt](test.rkt) jsou unit testy pro jednotlivé funkce aplikace
* v souboru [resources.rkt](resources.rkt) je uvedeno pár sudoku použité v testování, ale můžete je použít i v aplikaci

## Použití
Aplikace se spouští pomocí příkazu (get-solution *zde-vaše-vstupní-sudoku*). 

### Konkrétní příklady
1. pro:_
	(get-solution '((6 0 1 2 0 0 0 0 0)_
			(0 4 0 0 8 0 9 0 1)_
			(8 0 0 0 0 9 4 0 5)_
			(0 0 2 7 0 0 6 0 0)_
			(3 0 0 0 9 0 0 5 0)_
			(0 0 6 0 0 5 0 8 9)_
			(5 0 8 0 4 6 1 0 3)_
			(0 0 0 0 0 0 2 4 0)_
			(0 3 0 0 1 2 0 0 0)))_
  * aplikace vrátí:_
	+-----------------+_
	| 691 | 254 | 837 |_
	| 245 | 387 | 961 |_
	| 873 | 169 | 425 |_
	+-----------------+_
	| 952 | 738 | 614 |_
	| 384 | 691 | 752 |_
	| 716 | 425 | 389 |_
	+-----------------+_
	| 528 | 946 | 173 |_
	| 169 | 573 | 248 |_
	| 437 | 812 | 596 |_
	+-----------------+_
2. pro:_
	(get-solution '((1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)_
		        (1 1 1 1 1 1 1 1 1)))_
  * aplikace vrátí:_
  	Entered sudoku has duplicates in it, so it cannot be solved.-1_
3. pro:_
	(get-solution '((0 7 0 3 0 1 4 0 0)_
		        (0 0 4 0 8 0 0 6 2)_
		        (5 0 0 0 0 2 0 1 0)_
		        (2 0 0 7 0 0 0 0 3)_
		        (7 0 0 0 6 0 0 8 0)_
		        (0 9 0 4 0 3 5 0 0)_
		        (8 0 0 2 0 0 6 0 0)_
		        (0 0 1 0 0 6 0 4 0)))_
  * aplikace vrátí:_
  	Entered sudoku isn't 9x9, so it cannot be solved.-2
