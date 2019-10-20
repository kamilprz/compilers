
%{
int evenCount = 0;
%}

%%

[0-9]+   { if(atoi(yytext) % 2 == 0) {evenCount++;} }
\n       {}
.        {}

%%

int main()
{
    yylex();
    printf("%d\n", evenCount);
    return 0;
}

