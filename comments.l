
%{

%}

%%

"**".*          {}
"{"[^}]*"}"     {}
\".*\"          {printf("%s",yytext);}
"}"[^}]*        {printf("syntax error\n");}
"{"[^}]*        {printf("syntax error\n");}
\n              {printf("%s",yytext);}
.               {printf("%s",yytext);}

%%

int main()
{
    yylex();
    return 0;
}
