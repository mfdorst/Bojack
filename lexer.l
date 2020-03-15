%{
  #include "token.h"
  #include "parser.hpp"
  #include <string>
  #include <cstdio>
  // register keyword is removed in C++17
  // replace all occurences of 'register' with nothing
  #define register

  extern bool g_newline_required;

  //#define DEBUG
  #ifdef DEBUG
    void debug(const char * msg) {
      puts(msg);
    }
  #else
    void debug(const char *) {}
  #endif

%}
%option noyywrap

%%
[ \t]+ ;
[0-9]*\.?[0-9]+ {
  debug(yytext);
  yylval.token = new Token(yytext, Number);
  return TNumber;
}
if {
  debug(yytext);
  yylval.token = new Token("if", If);
  return TIf;
}
[a-zA-Z_][a-zA-Z0-9_]* {
  debug(yytext);
  yylval.token = new Token(yytext, Ident);
  return TIdent;
}
= {
  debug(yytext);
  yylval.token = new Token("=", Assign);
  return TAssign;
}
\+ {
  debug(yytext);
  yylval.token = new Token("+", Add);
  return TAdd;
}
\- {
  debug(yytext);
  yylval.token = new Token("-", Sub);
  return TSub;
}
\* {
  debug(yytext);
  yylval.token = new Token("*", Mult);
  return TMult;
}
\/ {
  debug(yytext);
  yylval.token = new Token("/", Div);
  return TDiv;
}
\( {
  debug(yytext);
  yylval.token = new Token("(", LParen);
  return TLParen;
}
\) {
  debug(yytext);
  yylval.token = new Token(")", RParen);
  return TRParen;
}
\n {
  debug("\\n");
  return '\n';
}
%%
