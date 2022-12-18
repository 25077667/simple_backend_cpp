FROM debian:sid as drogon-builder
WORKDIR /src
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y build-essential cmake git ninja-build mold uuid-dev openssl libssl-dev zlib1g-dev libsqlite3-dev libjsoncpp-dev

# Compile drogon env layer
# Skip the submodule
RUN git clone https://github.com/drogonframework/drogon && \
    cd drogon && \
    git checkout v1.8.2 && git submodule update --init --recursive && \
    mkdir build && cd build && \
    cmake -DCMAKE_LINKER=$(which mold) .. -G Ninja && \ 
    ninja -v && \
    ninja install

# Build All handlers
FROM drogon-builder as server-builder
WORKDIR /src
COPY ["CMakeLists.txt", "main.cpp", "/src/"]
COPY ["server/", "/src/server/"]
# jsoncpp linking issue: https://github.com/stardust95/TinyCompiler/issues/2
RUN ln -s /usr/include/jsoncpp/json/ /usr/include/json && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_LINKER=$(which mold) .. -G Ninja && \ 
    ninja -v

FROM debian:unstable-slim
WORKDIR /app
RUN apt-get update -y && \
    apt-get install -y libssl-dev zlib1g-dev libsqlite3-dev uuid-dev libjsoncpp-dev

COPY --from=server-builder --chown=1000:1000 /src/build/simple-web .

CMD ./simple-web
