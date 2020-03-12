#include "ast.h"
#include <fmt/core.h>

std::string tree_view(ASTNode const& tree,
                      std::string current_prefix,
                      std::string next_prefix,
                      bool last)
{
  std::string branch_symbol = last ? "└-" : "├-";
  std::string token_str = tree.has_token() ? tree.token->value : "Node";
  std::string view = fmt::format("{}{} {}\n", current_prefix, branch_symbol, token_str);
  
  if (tree.children.size() == 0) {
    return view;
  }

  for (size_t i = 0; i < tree.children.size(); i++) {
    if (i < tree.children.size() - 1) {
      view += tree_view(*tree.children[i], next_prefix, fmt::format("{}|  ", next_prefix), false);
    } else {
      view += tree_view(*tree.children[i], next_prefix, fmt::format("{}   ", next_prefix), true);
    }
  }

  return view;
}

std::string ASTNode::to_str() {
  return tree_view(*this, "", "   ", true);
}
