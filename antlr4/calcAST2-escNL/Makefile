all: app/Node.class

app/Node.class:	app/Node.java Calc.g4 app/CalcParser.java
	javac app/*.java -d app

app/Node.java:	Node.java 
	mkdir -p app
	cp *.java app

app/CalcParser.java:	Calc.g4
	antlr4 Calc.g4 -no-listener -no-visitor -o app

clean:
	rm -r app

