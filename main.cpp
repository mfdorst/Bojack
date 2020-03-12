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

  printf("%s\n", g_program->to_str().c_str());
  
  return 0;
}
