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
  ASTNode(std::string token_value, TokenType token_type) : token(std::make_shared<Token>(token_value, token_type)) {}

  void add_child(Token * token) {
    children.push_back(std::make_shared<ASTNode>(token));
  }

  void add_child(ASTNode * node) {
    children.push_back(std::shared_ptr<ASTNode>(node));
  }

  bool has_token() const {
    return token != nullptr;
  }

  std::string to_str();
};

extern int yyparse(void);

extern std::shared_ptr<ASTNode> g_program;
