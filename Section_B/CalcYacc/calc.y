%{
#include<stdio.h>
%}
%token NAME NUMBER
%%
statement:
NAME '=' expression
|
expression { printf("= %d", $1); }
;
expression: expression '+' NUMBER
{ $$ = $1 + $3; }
| expression '-' NUMBER
{ $$ = $1 - $3; }
|
NUMBER
{ $$ = $1; }
;
%%
main()
{
yyparse();
}
yyerror(s)
char *s;
{
fprintf(stderr, "%s\n",s);
}
