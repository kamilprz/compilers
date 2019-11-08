%{
  #include "romcalc.tab.h"
%}

%%
"I"             {return ONE;}
"V"             {return FIVE;}
"X"             {return TEN;}
"L"             {return FIFTY;}
"C"             {return HUNDRED;}
"D"             {return FIVEHUNDRED;}
"M"             {return THOUSAND;}
"*"             {return MUL;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"/"             {return DIV;}
"{"             {return LEFT;}
"}"             {return RIGHT;}
\n              {return EOL;}
.               {return ERROR;}
%%