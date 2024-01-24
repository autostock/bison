Inspired by: https://gnuu.org/2009/09/18/writing-your-own-toy-compiler/

A small example of a calculator written with flex / bison.

Produces a syntax tree like in calcAST.
But escaped NEWLINES (\\\n) handled like whitespace.

Compile using the `Makefile` 

    make

or manually on Linux, follow this steps:

    bison -d calc.y
    flex calc.l
    gcc calc.tab.c lex.yy.c -o calc -lm

usage

    ./calc <test.txt
    
