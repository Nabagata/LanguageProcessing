#this is a makefile
DeskCalc:
	bison -d DeskCalc.y
	flex Scanner.l
	gcc -o $@ lex.yy.c DeskCalc.tab.c -ll
