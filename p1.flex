%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "p1.tab.h"

%}

%%
"I"                 {yylval.i = 1; return T_ONE;}
"II"                {yylval.i = 2; return T_TWO;}
"III"               {yylval.i = 3; return T_THREE;}
"IV"				        {yylval.i = 4; return T_FOUR;}
"V"                 {yylval.i = 5; return T_FIVE;}
"IX"				        {yylval.i = 9; return T_NINE;}
"X"                 {yylval.i = 10; return T_TEN;}
"XL"				        {yylval.i = 40; return T_FOURTY;}
"L"                 {yylval.i = 50; return T_FIFTY;}
"XC"				        {yylval.i = 90; return T_NINETY;}
"C"                 {yylval.i = 100; return T_HUNDRED;}
"+"                 {return T_PLUS;}
"-"                 {return T_MINUS;}
"*"                 {return T_MULTIPLY;}
"/"                 {return T_DIVIDE;}
"."                 {return T_DOT;}
\n                  {return T_NEWLINE;}
%%
