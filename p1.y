%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>


extern int yylex();
extern int yyparse();
extern FILE* yyin;
int hun = 0;

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

%type<i> Num
%type<i> Hundred
%%

start: Num {printf("Number of Hundreds: %d\n Result: %d\n", hun, $1); hun = 0;}
;

Num: Hundred Hundred Hundred {$$ = $1 + $2 + $3;}
;

Hundred: T_HUNDRED {$$ = $1;hun++;}
		| 
;

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