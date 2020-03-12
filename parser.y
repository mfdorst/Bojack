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

  std::shared_ptr<ASTNode> g_program;
%}

// We use raw pointer types because union values must be default-constructible
%union {
  struct Token * token;
  struct ASTNode * node;
}

%token<token> TIdent TNumber

%nterm<node> Start Program

%start Start

%%

Start: Program {
  g_program = std::shared_ptr<ASTNode>($1)
};

Program: TIdent TNumber {
  $$ = new ASTNode();
  $$->add_child($1);
  $$->add_child($2);
};

%%
