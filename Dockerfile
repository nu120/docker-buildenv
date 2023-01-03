FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C \
    TARGET_BUILD_TYPE=32 \
    TARGET_OUTPUT_DIR=/opt/buildroot/output/mesonaxg_s420_32_release \
    PATH=$PATH:/opt/buildroot/toolchain/gcc/linux-i386/aarch64/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin/

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
        gcc-arm-none-eabi \
        git \
        graphviz \
        help2man \
        flex \
        jq \
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
    && git config --global user.email "nugulinux@gmail.com" \
    && git config --global user.name "nugulinux-bot" \
    && git config --global color.ui true \
    && mkdir -p /root/.ssh \
    && ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts \
    && pip3 install meson ninja

COPY welcome.sh /usr/bin/
ENTRYPOINT ["/usr/bin/welcome.sh"]
CMD ["/bin/bash"]
