%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  void yyerror(char *s);
  int yylex();
  int yyparse();

  void print_roman(int a)
  {
      int i = 0;
      char* sign = "";
      if(a==0){
        printf("Z");
      }
      else if(a<0){
        sign="-";
        a*=-1;
      }
      char M[1000];
      strcpy (M,"");
      for(i = 0; i<a/1000; i++)
        strcat(M,"M");
      char* C[] = {"","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"};
      char* X[] = {"","X","XX","XXX","XL","L","LX","LXX","LXXX","XC"};
      char* I[] = {"","I","II","III","IV","V","VI","VII","VIII","IX"};
      printf("%s%s%s%s%s\n",sign,M,C[(a%1000)/100],X[(a%100)/10],I[(a%10)]);
  }

%}

%output "romcalc.tab.c"
%token ONE FIVE TEN FIFTY HUNDRED FIVEHUNDRED THOUSAND
%left LEFT RIGHT
%left PLUS MINUS
%left MUL DIV
%token EOL ERROR
%%

run:
| run Expression EOL {print_roman($2);}
| ERROR {printf("syntax error\n"); return 0;}
;

Expression: Thousand
| Expression MUL Expression	            {$$=$1*$3;}
| Expression DIV Expression	            {$$=$1/$3;}
| Expression PLUS Expression	        {$$=$1+$3;}
| Expression MINUS Expression	        {$$=$1-$3;}
| LEFT Expression RIGHT			        {$$=$2;}
;

Thousand: FiveHundreds                  {$$=$1;}
| THOUSAND Thousand                     {$$=1000+$2;}
;

FiveHundreds: Hundreds
  | FIVEHUNDRED Hundreds                {$$=500+$2;}
  | HUNDRED FIVEHUNDRED Fifties         {$$=400+$3;}
  | HUNDRED THOUSAND Fifties            {$$=900+$3;}
;

Hundreds: Fifties
  | HUNDRED Fifties                     {$$=100+$2;}
  | HUNDRED HUNDRED Fifties             {$$=200+$3;}
  | HUNDRED HUNDRED HUNDRED Fifties     {$$=300+$4;}
;

Fifties: Tens
  | TEN HUNDRED Fives                   {$$=90+$3;}
  | FIFTY Tens                          {$$=50+$2;}
  | TEN FIFTY Fives                     {$$=40+$3;}
;

Tens: Fives
  | TEN TEN Fives                       {$$=20+$3;}
  | TEN TEN TEN Fives                   {$$=30+$4;}
  | TEN Fives                           {$$=10+$2;}
;

Fives: Ones
  | ONE TEN                             {$$=9;}
  | ONE FIVE                            {$$=4;}
  | FIVE Ones                           {$$=5+$2;}
;

Ones:                                   {$$=0;}
  | ONE                                 {$$=1;}
  | ONE ONE                             {$$=2;}
  | ONE ONE ONE                         {$$=3;}
;

%%

int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
	printf("syntax error\n");
}