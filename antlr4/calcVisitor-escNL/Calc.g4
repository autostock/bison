grammar Calc;

/* This will be the entry point of our parser.  */
input: line
	   | input line
;

line: Eol
    | expression Eol
;

expression: Number	
	  | expression T_MULTIPLY expression
	  | expression T_DIVIDE expression
	  | expression T_PLUS expression
	  | expression T_MINUS expression
	  | T_LEFT expression T_RIGHT
;

/* A number: can be an integer value, or a decimal value */
Number:    ('0'..'9')+ ('.' ('0'..'9')+)?
    ;

Eol: '\n'+ | EOF ;

T_PLUS: '+' ;
T_MINUS: '-' ; 
T_MULTIPLY: '*' ;
T_DIVIDE: '/' ;
T_LEFT: '(' ;
T_RIGHT: ')' ;

/* We're going to ignore all white space characters */
WS:    ([ \t\r]+|'\\''\n') -> skip;

