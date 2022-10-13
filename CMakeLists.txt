cmake_minimum_required(VERSION 3.12)

project(simple-web CXX)
set(CMAKE_CXX_STANDARD 20)

add_executable(simple-web main.cpp)
add_subdirectory(src)
target_link_libraries(simple-web PUBLIC server)