%{
#include<stdio.h>
int lines=0,words=0,digits=0,lowercase=0,uppercase=0,special=0,total=0;
%}
%%
\n {lines++;words++;}
[\t ' '] {words++;}
[A-Z] {uppercase++;}
[a-z] {lowercase++;}
[0-9] {digits++;}
[.,'_','@','#','!',':',')','('] {special++;}
%%
main(void)
{
yyin = fopen("input.txt", "r");
yylex();
total = uppercase+lowercase+special;
printf("File contains:\n");
printf("Lines:\t%d\n", lines);
printf("Words:\t%d\n", words);
printf("Uppercase Letters:\t%d\n", uppercase);
printf("Lowercase Letters:\t%d\n", lowercase);
printf("Digits:\t%d\n", digits);
printf("Special Characters:\t%d\n", special);
printf("Total characters:\t%d\n", total);
}
int yywrap()
{
return(1);
}
