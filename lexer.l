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
= {
  yylval.token = new Token("=", Assign);
  return TAssign;
}
\+ {
  yylval.token = new Token("+", Add);
  return TAdd;
}
\- {
  yylval.token = new Token("-", Sub);
  return TSub;
}
\* {
  yylval.token = new Token("*", Mult);
  return TMult;
}
\/ {
  yylval.token = new Token("/", Div);
  return TDiv;
}
\( {
  yylval.token = new Token("(", LParen);
  return TLParen;
}
\) {
  yylval.token = new Token(")", RParen);
  return TRParen;
}
%%
