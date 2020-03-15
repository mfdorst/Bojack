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
  bool g_newline_required = false;
%}

// We use raw pointer types because union values must be default-constructible
%union {
  struct Token * token;
  struct ASTNode * node;
}

%token<token> TIdent TNumber TAssign TAdd TSub TMult TDiv TLParen TRParen TIf

%nterm<node> Start Block Statement Assignment Expr Term Factor

%start Start

%%

Start: Block
{
  g_program = std::shared_ptr<ASTNode>($1);
  g_program->token = std::make_shared<Token>("Block", Block);
};

Block:
Statement
{
  $$ = new ASTNode();
  $$->add_child($1);
}
| Block Statement
{
  $1->add_child($2);
};

Statement: Assignment '\n'
{
  $$ = $1;
}
| TIf Expr '{' Block '}'
{
  $$ = new ASTNode("If", If);
  ASTNode * cond = new ASTNode("Condition", Condition);
  cond->add_child($2);
  $$->add_child(cond);
  $$->add_child($4);
};

Assignment: TIdent TAssign Expr
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
