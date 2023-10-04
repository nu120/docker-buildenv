FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C

# provide by docker buildx
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

ENV TARGETPLATFORM=$TARGETPLATFORM \
    TARGETOS=$TARGETOS \
    TARGETARCH=$TARGETARCH \
    TARGETVARIANT=$TARGETVARIANT \
    CROSS_TRIPLE=arm-none-linux-gnueabihf \
    CROSS_ROOT=/opt/toolchain \
    CROSS_SYSROOT=/opt/sysroot \
    OUTDIR=/opt/output \
    ARCH=arm \
    PATH=$PATH:/opt/toolchain/bin:/root/.cargo/bin

ENV AS=${CROSS_TRIPLE}-as \
    AR=${CROSS_TRIPLE}-ar \
    CC=${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_TRIPLE}-g++ \
    LD=${CROSS_TRIPLE}-ld \
    STRIP=${CROSS_TRIPLE}-strip \
    RANLIB=${CROSS_TRIPLE}-ranlib \
    CROSS_COMPILE=${CROSS_TRIPLE}- \
    PKG_CONFIG_LIBDIR=${CROSS_SYSROOT}/usr/lib/pkgconfig \
    PKG_CONFIG_SYSROOT_DIR=${CROSS_SYSROOT} \
    STAGING_DIR=${CROSS_SYSROOT} \
    CMAKE_TOOLCHAIN_FILE=${CROSS_ROOT}/Toolchain.cmake \
    DEB_HOST_GNU_TYPE=arm-none-linux-gnueabihf \
    DEB_HOST_MULTIARCH=arm-none-linux-gnueabihf \
    DEB_HOST_ARCH_OS=linux \
    TOOLCHAIN_DIR=gcc-arm-10.3-2021.07-x86_64-arm-none-linux-gnueabihf

# rust cargo options
#  cargo build -vv --target=armv7-unknown-linux-gnueabihf
ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-none-linux-gnueabihf-gcc \
    CC_armv7_unknown_Linux_gnueabihf=arm-none-linux-gnueabihf-gcc \
    CXX_armv7_unknown_linux_gnueabihf=arm-none-linux-gnueabihf-g++

COPY toolchain /opt/toolchain
COPY Toolchain.cmake cross-file.txt /opt/toolchain/

RUN apt update \
    && apt install -y \
        build-essential \
        cmake \
        curl \
        git \
        pkg-config \
        sed \
        tree \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /opt/toolchain/arm-none-linux-gnueabihf/libc /opt/sysroot \
    && cp -a /opt/toolchain/arm-none-linux-gnueabihf/include/* /opt/sysroot/usr/include/ \
    && ln -s /usr/bin/pkg-config /usr/bin/arm-none-linux-gnueabihf-pkg-config \
    && ln -s /opt/sysroot/usr/lib /usr/lib/arm-none-linux-gnueabihf \
    && git config --global --add safe.directory '*' \
    && curl https://sh.rustup.rs -sSf | bash -s -- -y \
    && rustup target add armv7-unknown-linux-gnueabihf \
    && rm -rf /root/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/doc
