grammar Calc;

@header {
// hello header
}

@parser::members {

/** the top level root node of our final AST
*/
static Node root; 

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
calculation returns [Node node]: line			{ $node=$line.node; root=$node; }
	   | p1=calculation p2=line					{ $node=new Node("list(line)", $p1.node, $p2.node); root=$node; }
;

line returns [Node node]: Eol					{ $node=null; }
    | expression Eol							{ $node=$expression.node; }
;

expression returns [Node node]: number			{ $node=$number.node; }							
	  | p1=expression T_DIVIDE p2=expression	{ $node=new Node("/", $p1.node, $p2.node); }
	  | p1=expression T_MULTIPLY p2=expression	{ $node=new Node("*", $p1.node, $p2.node); }
	  | p1=expression T_PLUS p2=expression		{ $node=new Node("+", $p1.node, $p2.node); }
	  | p1=expression T_MINUS p2=expression		{ $node=new Node("-", $p1.node, $p2.node); }
	  | T_LEFT expression T_RIGHT				{ $node=$expression.node; }
;

/* A number: can be an integer value, or a decimal value */
number returns [Node node]:
	   T_INT		{ $node=new Node("int", null, null);	$node.ival=Integer.valueOf($text); }
		| T_FLOAT	{ $node=new Node("float", null, null);	$node.fval=Float.valueOf($text); }
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

