/* Scanner for the calculator */

%{
 #include "DeskCalc.tab.h"
%}

%%
[0-9]+"."[0-9]* |
"."?[0-9]+ { yylval.d = atof(yytext); return NUM;}
"+" { return ADD;}
"-" { return SUB;}
"*" { return MUL; }
"/" { return DIV; }
"@" { return EXP; }
"um" { return UM; }
"|" {return ABS; }
\n { return EOL; }

%%
