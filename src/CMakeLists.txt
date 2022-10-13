set(HEADER_DIRS "${CMAKE_SOURCE_DIR}/include")

add_library(server STATIC server.cpp ${HEADER_DIRS}/server.hpp)
target_include_directories(server PUBLIC ${HEADER_DIRS})