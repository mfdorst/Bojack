cmake_minimum_required(VERSION 3.15)
project(bojack)
set(CMAKE_CXX_STANDARD 17)

#target_compile_features(bojack PRIVATE cxx_std_17)

find_package(BISON)
find_package(FLEX)
bison_target(parser parser.y ${CMAKE_CURRENT_SOURCE_DIR}/parser.cpp)
flex_target(scanner lexer.l ${CMAKE_CURRENT_SOURCE_DIR}/lexer.cpp)
add_flex_bison_dependency(scanner parser)

add_executable(bojack main.cpp ${FLEX_scanner_OUTPUTS} ${BISON_parser_OUTPUTS} token.h ast.h)
