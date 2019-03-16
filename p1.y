%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>


extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int i;
	float f;
}

%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_DOT T_NEWLINE
%token<i> T_ONE
%token<i> T_FOUR
%token<i> T_FIVE
%token<i> T_NINE
%token<i> T_TEN
%token<i> T_FOURTY
%token<i> T_FIFTY
%token<i> T_NINETY
%token<i> T_HUNDRED
%%

YOURGRAMMAR: SOMETHINGELSE
	| //Epsilon

SOMETHINGELSE: T_PLUS { printf("This part is the attribute grammar of your CFG"); }

%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}