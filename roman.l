
%{

# include "roman.tab.h"
void yyerror(char *s);
int yylex();
int yylval;

%}

%%

"I" {yylval = 1; return NUM;}
"V" {yylval = 5; return NUM;}
"X" {yylval = 10; return NUM;}
"L" {yylval = 50; return NUM;}
"C" {yylval = 100; return NUM;}
"D" {yylval = 500; return NUM;}
"M" {yylval = 1000; return NUM;}
"IV" {yylval = 4; return NUM;}
"IX" {yylval = 9; return NUM;}
"XL" {yylval = 40; return NUM;}
"XC" {yylval = 90; return NUM;}
"CD" {yylval = 400; return NUM;}
"XD" {yylval = 490; return NUM;}
"CM" {yylval = 900; return NUM;}
"I"{4,} {return EOL;}
"X"{4,} {return EOL;}
"C"{4,} {return EOL;}
"CMCC" {return EOL;}
\n {return EOL;}
. {}

%%