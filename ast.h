///===-- ast.h -----------------------------------------------------------------------* C++ *-===///
/// Defines types to do with the Abstract Syntax Tree
///===----------------------------------------------------------------------------------------===///
#pragma once
#include <memory>
#include <optional>
#include <variant>
#include <vector>
#include "token.h"

enum ASTNodeType {
  ASTIdent,
  ASTNumber
};

struct ASTNode {
  std::shared_ptr<Token> token;
  std::vector<std::shared_ptr<ASTNode>> children;

  ASTNode() {}
  ASTNode(Token * token) : token(std::shared_ptr<Token>(token)) {}
  ASTNode(Token token) : token(std::make_shared<Token>(token)) {}

  void add_child(Token * token) {
    children.push_back(std::make_shared<ASTNode>(token));
  }
};

extern int yyparse(void);

extern std::shared_ptr<ASTNode> g_program;
