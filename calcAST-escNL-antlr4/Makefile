all: app/Run.class

app/Run.class:	app/Run.java Calc.g4 app/CalcBaseVisitorImpl.java app/CalcBaseVisitor.java
#	javac -cp $$CLASSPATH app/*.java -d app
	javac app/*.java -d app

app/Run.java:	Run.java
	mkdir -p app
	cp Run.java app

app/CalcBaseVisitorImpl.java:	CalcBaseVisitorImpl.java
	mkdir -p app
	cp CalcBaseVisitorImpl.java app

app/CalcBaseVisitor.java:	Calc.g4
	antlr4 Calc.g4 -no-listener -visitor -o app

clean:
	rm app/*

