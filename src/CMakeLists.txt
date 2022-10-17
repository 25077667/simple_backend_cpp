set(HEADER_DIRS "${CMAKE_SOURCE_DIR}/include")

add_library(server STATIC server.cpp)
target_include_directories(server PUBLIC ${HEADER_DIRS} ${CMAKE_SOURCE_DIR}/handlers/)
target_link_libraries(server all_handlers)