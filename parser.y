%{
  #include "token.h"
  #include "ast.h"
  #include <memory>
  #include <cstdio>
  #include <cstdlib>
  
  #define YYERROR_VERBOSE

  extern int yylex();

  void yyerror(const char * err) {
    printf("Error: %s\n", err);
    exit(1);
  }

  ASTNode program;
%}

%union {
  struct Token * token;
  struct ASTNode * node;
}

// Terminals
%token<token> TIdent TNumber

// Non-terminals
%token<node> Program

%start Start

%%

Start: TIdent TNumber {
  program = ASTNode();
  program.add_child($1);
  program.add_child($2);
};

%%
