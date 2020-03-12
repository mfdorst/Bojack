%{
  #include "token.h"
  #include "ast.h"
  #include <memory>
  #include <cstdio>
  #include <cstdlib>
  
  #define YYERROR_VERBOSE
  #define YYDEBUG 1

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

%token<token> TIdent TNumber TAssign TAdd TSub TMult TDiv TLParen TRParen

%nterm<node> Start Assign Expr Term Factor

%start Start

%%

Start: Assign
{
  g_program = std::shared_ptr<ASTNode>($1)
};

Assign: TIdent TAssign Expr
{
  $$ = new ASTNode("=", Assign);
  $$->add_child($1);
  $$->add_child($3);
};

Expr:
Expr TAdd Term
{
  $$ = new ASTNode("+", Add);
  $$->add_child($1);
  $$->add_child($3);
}
| Expr TSub Term
{
  $$ = new ASTNode("-", Sub);
  $$->add_child($1);
  $$->add_child($3);
}
| Term
{
  $$ = $1;
};

Term:
Term TMult Factor
{
  $$ = new ASTNode("*", Mult);
  $$->add_child($1);
  $$->add_child($3);
}
| Term TDiv Factor
{
  $$ = new ASTNode("/", Div);
  $$->add_child($1);
  $$->add_child($3);
}
| Factor
{
  $$ = $1;
};

Factor:
TLParen Expr TRParen
{
  $$ = $2;
}
| TIdent
{
  $$ = new ASTNode($1);
}
| TNumber
{
  $$ = new ASTNode($1);
};

%%
