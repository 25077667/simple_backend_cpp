# Simple web app in C++

## Dependencies:
```
cmake
conan
```
A C++ compiler which is supporting C++20.

## Build:
```
mkdir build
conan install conanfile.txt --install-folder=build --build=missing
cd build
cmake ..
make
```