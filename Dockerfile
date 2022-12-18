FROM debian:sid as drogon-builder
WORKDIR /src/drogon
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y build-essential cmake git ninja-build mold nlohmann-json3-dev uuid-dev openssl libssl-dev zlib1g-dev

# Compile drogon env layer
RUN git clone https://github.com/drogonframework/drogon && \
    cd drogon && \
    git submodule update --init --recursive && \
    mkdir build && cd build && \
    cmake -DCMAKE_LINKER=$(which mold) .. -G Ninja && \ 
    ninja -v && \
    ninja install

# Build All handlers
FROM drogon-builder as server-builder
WORKDIR /src
COPY ["handlers", "/src/handlers/"]
COPY ["server", "/src/server"]
COPY []
RUN mkdir build && cd build && \
    cmake -DCMAKE_LINKER=$(which mold) .. -G Ninja && \ 
    ninja -v



COPY ["engine/CMakeLists.txt", "engine/conanfile.txt", "/src/engine/"]
RUN conan profile new default --detect && \
    conan profile update settings.compiler.libcxx=libstdc++11 default && \
    mkdir build && \
    conan install engine/conanfile.txt -if build --build=missing && \
    echo "Store conan caches"

# Leave the endpoint driver beyond conan cache  
COPY ["engine/", "/src/engine/"]

RUN cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_LINKER=$(which mold) ../engine -G Ninja && \
    ninja -v

FROM debian:unstable-slim
WORKDIR /app

COPY --from=builder --chown=1000:1000 /src/build/bin/engine .
COPY ../template/ /template/

CMD ./engine