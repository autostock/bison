%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "node.h"

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

Node *root; /* the top level root node of our final AST */

//#define SHOW(root)  printf("root=%p, Op=%s, left=%p, right=%p\n", name, root, root->OpCode, root->left, root->right)
#define SHOW(root)

%}


%union {
	Node * node;
	int ival;
	float fval;
}

%token <ival> T_INT
%token <fval> T_FLOAT

%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_NEWLINE
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type <node> number expression line calculation

%start calculation

%%

calculation: line { $$ = $1; root=$$; SHOW($$); }
	   | calculation line { $$ = malloc(sizeof(Node)); root=$$; $$->OpCode="list(line)"; $$->left=$1; $$->right=$2; SHOW($$); }
;

line: eol	{ $$ = NULL; }
    | expression eol
;

expression: number	
	  | expression T_PLUS expression	{ $$ = malloc(sizeof(Node)); $$->OpCode="+"; $$->left=$1; $$->right=$3; SHOW($$); }
	  | expression T_MINUS expression	{ $$ = malloc(sizeof(Node)); $$->OpCode="-"; $$->left=$1; $$->right=$3; }
	  | expression T_MULTIPLY expression	{ $$ = malloc(sizeof(Node)); $$->OpCode="*"; $$->left=$1; $$->right=$3; }
	  | expression T_DIVIDE expression	 { $$ = malloc(sizeof(Node)); $$->OpCode="/"; $$->left=$1; $$->right=$3; }
	  | T_LEFT expression T_RIGHT		{ $$ = $2; }
;

number: T_INT				{ $$ = malloc(sizeof(Node)); $$->OpCode="int"; $$->ival=$<ival>1; }
	| T_FLOAT				{ $$ = malloc(sizeof(Node)); $$->OpCode="float"; $$->fval=$<fval>1; }
;

eol: T_NEWLINE | YYEOF ;

%%

void traverse(Node * root, int level) {
	if (root==NULL) return;
	//printf("root=%p, Op=%c, level=%d\n", root, root->OpCode, level);
	printf("%*s%s", 4*level, "", root->OpCode);
	if (strcmp(root->OpCode, "int")==0) 	printf("(%i)", root->ival);
	if (strcmp(root->OpCode, "float")==0) 	printf("(%f)", root->fval);
	printf("\n");
	traverse(root->left,  level+1);
	traverse(root->right, level+1);
}

int main() {

#ifdef YYDEBUG
  yydebug = 0;
#endif
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));
	
	//printf("root=%p, size=%d\n", root, sizeof(Node));
	traverse(root, 0);
	printf("done\n");
	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
