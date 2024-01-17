FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C \
    TARGET_BOARD=s420 \
    TARGET_BUILD_TYPE=64 \
    TARGET_OUTPUT_DIR=/opt/buildroot/output/axg_s420_a6432_k54_release \
    CCACHE_COMPILERCHECK=content \
    CCACHE_LOGFILE=/var/log/ccache.log \
    FORCE_UNSAFE_CONFIGURE=1 \
    PATH=$PATH:/opt/buildroot/toolchain/gcc/linux-x86/arm/gcc-arm-none-eabi-6-2017-q2-update/bin

RUN apt update \
    && apt install -y \
        automake \
        autopoint \
        bc \
        bison \
        build-essential \
        ca-certificates \
        ccache \
        cmake \
        cpio \
        curl \
        dbus \
        elfutils \
        git \
        graphviz \
        help2man \
        flex \
        jq \
        libssl1.0-dev \
        moreutils \
        patch \
        pkg-config \
        python2.7 \
        python3-pip \
        python-numpy \
        python-matplotlib \
        rsync \
        sed \
        tcl \
        texinfo \
        tree \
        unzip \
        valac \
        vim \
        wget \
        xz-utils \
        zip \
    && dpkg --add-architecture i386 \
    && apt update \
    && apt-get install -y \
        libc6:i386 \
        libstdc++6:i386 \
        zlib1g:i386 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python python /usr/bin/python2.7 10 \
    && curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo \
    && chmod +x /usr/bin/repo \
    && sed -i '1 s/python/python3/' /usr/bin/repo \
    && git config --global user.email "nugulinux@gmail.com" \
    && git config --global user.name "nugulinux-bot" \
    && git config --global color.ui true \
    && git config --global --add safe.directory $TARGET_OUTPUT_DIR/build/uboot-next-2015-dev \
    && mkdir -p /root/.ssh \
    && ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts \
    && pip3 install meson ninja

COPY welcome.sh /usr/bin/
ENTRYPOINT ["/usr/bin/welcome.sh"]
CMD ["/bin/bash"]
