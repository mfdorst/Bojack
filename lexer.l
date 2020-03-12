%{
  #include "token.h"
  #include "parser.hpp"
  #include <string>

  // register keyword is removed in C++17
  // replace all occurences of 'register' with nothing
  #define register
%}
%option noyywrap

%%
[ \t\n] ;
[0-9]*\.?[0-9]+ {
  yylval.token = new Token(yytext, Number);
  return TNumber;
}
[a-zA-Z_][a-zA-Z0-9_]* {
  yylval.token = new Token(yytext, Ident);
  return TIdent;
}
. {
  yyterminate();
}
%%
