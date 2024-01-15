Inspired by: https://gnuu.org/2009/09/18/writing-your-own-toy-compiler/

A small example of a calculator written with flex / bison.

Ths time it produces a syntax tree.

Compile using the `Makefile` 

    $ make

or manually on Linux, follow this steps:

    $ bison -d calc.y
    $ flex calc.l
    $ gcc calc.tab.c lex.yy.c -o calc -lm

usage

    $ printf "3+4.5" | ./calc
    $ printf "3+4.5\n2*13\n30/((4+0.5)-(1+6))\n78" | ./calc
