///===-- token.h ---------------------------------------------------------------------* C++ *-===///
/// Defines types and functions relating to lexer tokens.
///===----------------------------------------------------------------------------------------===///

#pragma once
#include <memory>
#include <string>

enum TokenType {
  Ident,
  Number,
  InvalidToken
};

struct Token {
  std::string val;
  TokenType type;

  Token() {}
  Token(Token& token) : val(token.val), type(token.type) {}
  Token(std::string val, TokenType type) : val(val), type(type) {}
};

static std::string token_type_to_string(TokenType type) {
  switch (type) {
    case Ident:
      return "Ident";
    case Number:
      return "Number";
    case InvalidToken:
      return "InvalidToken";
  }
  return "InvalidType";
}
