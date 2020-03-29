%{
  #include "token.h"
  #include "parser.hpp"
  #include <string>
  #include <cstdio>
  // register keyword is removed in C++17
  // replace all occurences of 'register' with nothing
  #define register

  extern bool g_newline_required;

  #define DEBUG
  #ifdef DEBUG
    void debug(const char * msg) {
      puts(msg);
    }
  #else
    void debug(const char *) {}
  #endif

  TokenType operator_type(const char op) {
    switch(op) {
      case '=': return Assign;
      case '+': return Add;
      case '-': return Sub;
      case '*': return Mult;
      case '/': return Div;
      case '(': return LParen;
      case ')': return RParen;
      default: return InvalidToken;
    }
  }

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
[=\+\-\*\/\(\)] {
  debug(yytext);
  yylval.token = new Token(yytext, operator_type(yytext[0]));
  return yytext[0];
}
\n {
  debug("\\n");
  return '\n';
}
%%
