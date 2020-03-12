#include "token.h"
#include "ast.h"
#include <cstdio>

extern int yyparse();
extern FILE * yyin;
extern std::shared_ptr<ASTNode> g_program;

int main(int argc, const char** argv) {
  FILE * input = fopen("input.txt", "r");
  if (!input) {
    printf("Error opening file.\n");
    return 1;
  }
  yyin = input;
  yyparse();
  fclose(input);

  for (auto child : g_program->children) {
    if (child->token) {
      printf("Token: { type: %s, value: %s }\n",
             token_type_to_string(child->token->type).c_str(),
             child->token->val.c_str());
    } else {
      printf("No token.\n");
    }
  }
}
