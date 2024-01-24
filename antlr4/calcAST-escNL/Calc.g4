grammar Calc;

@header {
// hello header
}

@parser::members {

/** the top level root node of our final AST
*/
static Node root; 

List<Node> astStack = new ArrayList<Node>();

void traverse(Node root, int level) {
	if (root==null) return;
	System.out.printf("%-"+(4*level+1)+"s%s", "", root.OpCode);
	if ("int".equals(root.OpCode))		System.out.printf("(%s)", root.ival);
	if ("float".equals(root.OpCode))	System.out.printf("(%s)", root.fval);
	System.out.printf("\n");
	traverse(root.left,  level+1);
	traverse(root.right, level+1);
}

public static void main(String[] args) throws Exception {
    CharStream input = CharStreams.fromStream(System.in);
    CalcLexer lexer = new CalcLexer(input);
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    CalcParser parser = new CalcParser(tokens);
    ParseTree tree = parser.calculation();

   	parser.traverse(root, 0);
	System.out.printf("done\n");
}
}

/* This will be the entry point of our parser.  */
calculation: line			{ root=astStack.get(0); }
	   | calculation line	{ astStack.add(0, new Node("list(line)", astStack.remove(1), astStack.remove(0))); root=astStack.get(0); }
;

line: Eol					{ astStack.add(0, null); }
    | expression Eol
;

expression: number							
	  | expression T_DIVIDE expression		{ astStack.add(0, new Node("/", astStack.remove(1), astStack.remove(0))); }
	  | expression T_MULTIPLY expression	{ astStack.add(0, new Node("*", astStack.remove(1), astStack.remove(0))); } 
	  | expression T_PLUS expression		{ astStack.add(0, new Node("+", astStack.remove(1), astStack.remove(0))); }
	  | expression T_MINUS expression		{ astStack.add(0, new Node("-", astStack.remove(1), astStack.remove(0))); } 
	  | T_LEFT expression T_RIGHT			
;

/* A number: can be an integer value, or a decimal value */
number:   T_INT		{ astStack.add(0, new Node("int", null, null)); astStack.get(0).ival=Integer.parseInt($text); }
		| T_FLOAT	{ astStack.add(0, new Node("float", null, null)); astStack.get(0).fval=Float.parseFloat($text); }
;

T_INT: ('0'..'9')+
;

T_FLOAT: ('0'..'9')+ '.' ('0'..'9')+
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

