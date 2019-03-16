%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "p1.tab.h"

%}

%%
"I"                 {yylval.i = 1; return T_ONE;}
"V"                 {yylval.i = 5; return T_FIVE;}
"X"                 {yylval.i = 10; return T_TEN;}
"L"                 {yylval.i = 50; return T_FIFTY;}
"C"                 {yylval.i = 100; return T_HUNDRED;}
"+"                 {return T_PLUS;}
"-"                 {return T_MINUS;}
"*"                 {return T_PLUS;}
"/"                 {return T_DIVIDE;}
"."                 {return T_DOT;}
"\n"                {return T_NEWLINE;}
%%