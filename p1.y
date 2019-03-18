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
%token<i> T_TWO
%token<i> T_THREE
%token<i> T_FOUR
%token<i> T_FIVE
%token<i> T_NINE
%token<i> T_TEN
%token<i> T_FOURTY
%token<i> T_FIFTY
%token<i> T_NINETY
%token<i> T_HUNDRED



%type<i> Tens
%type<i> Digits
%type<i> More_Digits
%type<i> Roman_Num
%type<f> Factor
%type<f> Expr
%%

begin: begin Start 
     |
	 ;

Start: Expr T_NEWLINE     {if (fmod($1,1) != 0) printf("%f\n", $1); else printf("%d\n", (int)$1);}
;

Expr: Factor 						{$$ = $1;}
	| Factor T_PLUS Factor          {$$ = $1 + $3;}
	| Factor T_MINUS Factor 	    {$$ = $1 - $3;}
	| Factor T_MULTIPLY Factor      {$$ = $1 * $3;}
	| Factor T_DIVIDE Factor        {$$ = $1 / $3;}
	;

Factor: Roman_Num 					{$$ = $1;}
	  | Roman_Num T_DOT Roman_Num   {
                                    int places = floor(log10 (abs ($3))) + 1;
									int power = (int) pow(10.0, (double) places);
									$$ = $1 + ((double) $3/power);
                                    }
	  | 		  					{$$ = 0;}
;

Roman_Num: T_HUNDRED Tens						{$$ = $1 + $2;}
		| T_HUNDRED T_HUNDRED Tens 				{$$ = $1 + $2 + $3;}
		| T_HUNDRED T_HUNDRED T_HUNDRED Tens	{$$ = $1 + $2 + $3 + $4;}
		| Tens									{$$ = $1;}
		|                                       {$$ = 0;}
		;

Tens: T_TEN Digits 								{$$ = $1 + $2;}
	| T_TEN T_TEN Digits						{$$ = $1 + $2 + $3;}
	| T_TEN T_TEN T_TEN Digits					{$$ = $1 + $2 + $3 + $4;}
	| Digits									{$$ = $1;}
	| T_FIFTY Tens								{$$ = $1 + $2;}
	| T_FOURTY Digits							{$$ = $1 + $2;}
	| T_NINETY Digits							{$$ = $1 + $2;}
	|                                           {$$ = 0;}
	;

Digits: More_Digits								{$$ = $1;}
		| T_FOUR								{$$ = $1;}
		| T_FIVE More_Digits					{$$ = $1 + $2;}
		| T_NINE								{$$ = $1;}
		|										{$$ = 0;}
		;

More_Digits: T_ONE				    			{$$ = $1;}
			| T_TWO								{$$ = $1;}
			| T_THREE							{$$ = $1;}
			|									{$$ = 0;}
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