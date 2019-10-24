%define parse.error verbose
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern int yywrap();

void yyerror(const char *s);

int valid = 1;

int first(int n){
	int first = n;
  while(first >= 10)
      first = first / 10;
	return first;
}

%}

%union {
	int num;
}

%token ONE
%token FOUR
%token FIVE
%token NINE
%token TEN
%token FOURTY
%token FIFTY
%token NINETY
%token HUNDRED
%token FOURHUNDRED
%token FIVEHUNDRED
%token NINEHUNDRED
%token THOUSAND
%token EOL

%type <num> number letters

%%

numberList:											 {}
	| EOL													 {printf("syntax error\n");}
	| numberList number EOL        {if(valid)printf("%d\n",$2);else{printf("syntax error\n"); exit(0);}};
	;

number: letters
	| number letters		{if($2>=$1||(first($1)==4&&$1/$2<5.0)||(first($1)==9&&$1/$2<10.0))valid = 0;$$ = $1 + $2;}
	;

letters: ONE					{$$ = yylval.num;}
	| FOUR							{$$ = 4;}
	| FIVE							{$$ = yylval.num;}
	| NINE 							{$$ = 9;}
	| TEN								{$$ = yylval.num;}
	| FOURTY						{$$ = 40;}
	| FIFTY							{$$ = yylval.num;}
	| NINETY						{$$ = 90;}
	| HUNDRED						{$$ = yylval.num;}
	| FOURHUNDRED				{$$ = 400;}
	| FIVEHUNDRED				{$$ = yylval.num;}
	| NINEHUNDRED       {$$ = 900;}
	| THOUSAND					{$$ = yylval.num;}
 	;

%%

int main() {
	yyparse();
	return 0;
}

void yyerror(const char *s) {
	printf("Error: %s\n", s);
	exit(0);
}