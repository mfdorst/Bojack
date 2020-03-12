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

%token<token> TIdent TNumber

%nterm<node> Start Program

%start Start

%%

Start: Program {
  program = *$1
};

Program: TIdent TNumber {
  $$ = new ASTNode();
  $$->add_child($1);
  $$->add_child($2);
};

%%
