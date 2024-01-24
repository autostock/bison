Hallo Helmut,

hier fünf Beispiele:

* bison
1. bison/calc: errechnet das Resultat und gibt dies aus.
1. bison/calcAST: erzeugt "nur" einen Syntaxbaum und gibt ihn aus.
1. bison/calcAST-escNL: wie bison/calcAST jedoch kann man ein NL mittels \ escapen und somit eine Expression auf viele Zeilen verteilen.

* antlr4
1. antlr4/calcAST-escNL: wie bison/calcAST jedoch mit ANTLR4.
1. antlr4/calcVisitor-escNL: wie bison/calcAST-escNL jedoch mit ANTLR4. Liefert Tree (kein AST) und(!) Resultat der Expression.

