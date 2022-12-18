FILE(GLOB ALL_HANDLERS *.cpp)
FILE(GLOB ALL_HANDLERS_H *.hpp)

# find_package(drogon REQUIRED PATHS ${CMAKE_INSTALL_LIBDIR}/cmake/Drogon)

add_library(all_handlers STATIC ${ALL_HANDLERS} ${ALL_HANDLERS_H})