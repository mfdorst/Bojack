cmake_minimum_required(VERSION 3.15)
project(bojack)
set(CMAKE_CXX_STANDARD 20)

#target_compile_features(bojack PRIVATE cxx_std_17)

find_package(BISON)
find_package(FLEX)
bison_target(parser parser.y ${CMAKE_CURRENT_SOURCE_DIR}/parser.cpp)
flex_target(scanner lexer.l ${CMAKE_CURRENT_SOURCE_DIR}/lexer.cpp)
add_flex_bison_dependency(scanner parser)

find_package(fmt)

add_executable(bojack main.cpp ${FLEX_scanner_OUTPUTS} ${BISON_parser_OUTPUTS} token.h ast.cpp ast.h)

target_link_libraries(bojack fmt::fmt)
