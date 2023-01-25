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
    CROSS_TRIPLE=arm-linux-gnueabihf \
    CROSS_ROOT=/opt/toolchain \
    CROSS_SYSROOT=/opt/sysroot \
    OUTDIR=/opt/output \
    ARCH=arm \
    PATH=$PATH:/opt/toolchain/bin

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
    DEB_HOST_GNU_TYPE=arm-linux-gnueabihf \
    DEB_HOST_MULTIARCH=arm-linux-gnueabihf \
    DEB_HOST_ARCH_OS=linux \
    TOOLCHAIN_DIR=gcc-linaro-6.3.1-2017.05-x86_64_arm-linux-gnueabihf

COPY toolchain /opt/toolchain
COPY Toolchain.cmake cross-file.txt /opt/toolchain/

RUN apt update \
    && apt install -y \
        build-essential \
        cmake \
        git \
        pkg-config \
        sed \
        tree \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /opt/toolchain/arm-linux-gnueabihf/libc /opt/sysroot \
    && cp -a /opt/toolchain/arm-linux-gnueabihf/include/* /opt/sysroot/usr/include/ \
    && ln -s /usr/bin/pkg-config /usr/bin/arm-linux-gnueabihf-pkg-config \
    && ln -s /opt/sysroot/usr/lib /usr/lib/arm-linux-gnueabihf \
    && git config --global --add safe.directory '*'

