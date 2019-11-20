

%{
  #include "calcwithvariables.tab.h"
%}

%%

[a-z]           {yylval.cval = yytext[0];return ID;}
[0-9]           {yylval.intval = atoi(yytext);return NUM;}
\n              {return EOL;}
\               {return SPACE;}
\;              {return SC;}
:=              {return ASSIGN;}
\+              {return PLUS;}
-               {return MINUS;}
\*              {return MULT;}
\/              {return DIV;}
print           {return PRINT;}
.               {return ERROR;}

%%