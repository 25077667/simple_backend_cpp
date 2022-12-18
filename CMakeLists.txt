cmake_minimum_required(VERSION 3.12)

project(simple-web CXX)
set(CMAKE_CXX_STANDARD 20)

# See the gcc compiler bug: [105545](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105545)
set (MY_CXX_FLAGS "-Wno-error=restrict -pthread -fcoroutines")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${MY_CXX_FLAGS}")

set(CMAKE_CXX_FLAGS_DEBUG_INIT "-O0 -ggdb -fsanitize=address")
set(CMAKE_CXX_FLAGS_RELEASE "-Ofast -s -flto=auto -Bstatic")

option (FORCE_COLORED_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)." TRUE)
if (${FORCE_COLORED_OUTPUT})
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
       add_compile_options (-fdiagnostics-color=always)
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
       add_compile_options (-fcolor-diagnostics)
    endif ()
endif ()

add_subdirectory(server)
add_executable(simple-web main.cpp)
add_subdirectory(src)
add_subdirectory(Django_cpp)
add_subdirectory(handlers)
add_subdirectory(drogon)
target_link_libraries(simple-web PRIVATE server drogon Django)
