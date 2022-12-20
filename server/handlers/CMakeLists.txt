FILE(GLOB ALL_HANDLERS *.cpp)
FILE(GLOB ALL_HANDLERS_H *.hpp)

add_library(all_handlers STATIC ${ALL_HANDLERS} ${ALL_HANDLERS_H})
target_include_directories(all_handlers PUBLIC ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/../../drogon) 