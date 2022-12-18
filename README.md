# Simple backend app in C++

## Dependencies:
```
cmake
ninja
mold
```
A C++ compiler which is supporting C++20.

## Build:
```
git submodule update --init --recursive
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_LINKER=$(which mold) ../engine -G Ninja && \
ninja -v
```