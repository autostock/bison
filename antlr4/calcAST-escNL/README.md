Inspired by:
	
	https://gnuu.org/2009/09/18/writing-your-own-toy-compiler/
	https://github.com/shmatov/antlr4-calculator
	https://github.com/antlr/antlr4/blob/4.13.1/doc/actions.md
	https://stackoverflow.com/questions/29971097/how-to-create-ast-with-antlr4

A small example of a calculator written with antlr4.

Produces a syntax tree like in calcAST and calculate the arithmetic result
But escaped NEWLINES (\\\n) handled like whitespace.

Installation

	sudo apt install openjdk-19-jdk-headless
	sudo apt install antlr4
	
Find my class path in the executable antlr4

	which antlr4
	cat /usr/bin/antlr4
	export CLASSPATH=/usr/share/java/stringtemplate4.jar:/usr/share/java/antlr4.jar:/usr/share/java/antlr4-runtime.jar:/usr/share/java/antlr3-runtime.jar/:/usr/share/java/treelayout.jar

Compile using the `Makefile` 

    make
    
or manually on Linux, follow this steps:
	
	mkdir app
	antlr4 Calc.g4 -no-listener -no-visitor -o app
	cp *.java app
	javac app/*.java -d app 

Usage

	printf '(3+7)-2*9\n6.543+7' | java -cp $CLASSPATH:app CalcParser
	
or

    java -cp $CLASSPATH:app CalcParser <test.txt
    
