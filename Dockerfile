FROM alpine

RUN apk add --no-cache \
    git \
    make \
    cmake \
    libstdc++ \
    gcc \
    g++ \
    automake \
    libtool \
    autoconf \
    linux-headers \
    libuv-dev \
    openssl-dev \
    hwloc-dev

WORKDIR /app 

COPY . . 

RUN cmake -B build/ \
    -DCMAKE_BUILD_TYPE=Release \
    -DWITH_HWLOC=ON \
    -DWITH_OPENCL=OFF \
    -DWITH_CUDA=OFF \
    -S .

RUN cmake --build build/ -j$(nproc)

RUN ls build/
RUN mv /app/build/xmrig-notls /usr/local/bin/xmrig && \
    rm -rf /app

ENTRYPOINT ["xmrig"]
