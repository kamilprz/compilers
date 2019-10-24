%{
#include <string.h>
#include "roman.tab.h"

%}

%%
IV                {return FOUR;}
IX                {return NINE;}
XL                {return FOURTY;}
XC                {return NINETY;}
CD                {return FOURHUNDRED;}
CM                {return NINEHUNDRED;}
I{1,3}            {yylval.num = strlen(yytext)*1; return ONE;}
V{1,3}            {yylval.num = strlen(yytext)*5; return FIVE;}
X{1,3}            {yylval.num = strlen(yytext)*10; return TEN;}
L{1,3}            {yylval.num = strlen(yytext)*50; return FIFTY;}
C{1,3}            {yylval.num = strlen(yytext)*100; return HUNDRED;}
D{1,3}            {yylval.num = strlen(yytext)*500; return FIVEHUNDRED;}
M{1,3}            {yylval.num = strlen(yytext)*1000; return THOUSAND;}
\n                {yylval.num = 0; return EOL;}
[^I|V|X|L|C|D|M|\n]*
%%