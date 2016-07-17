FROM funkyfuture/nest-of-serpents

ENV PYSTON_VERSION=0.5.1
RUN build_deps="automake cmake libtool ninja-build pkg-config ccache clang libbz2-dev libffi-dev libgmp3-dev liblzma-dev libmpfr-dev python-dev texlive-extra-utils" \
 && apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends $build_deps \
 && cd /root \
 && git config --global user.name "nest-of-serpents" \
 && git config --global user.email "funkyfuture+nest-of-serpents@hub.docker.com" \
 && git clone https://github.com/dropbox/pyston.git \
 && git clone https://github.com/llvm-mirror/llvm.git pyston_deps/llvm-trunk \
 && git clone https://github.com/llvm-mirror/clang.git pyston_deps/llvm-trunk/tools/clang \
 && cd pyston \
 && git checkout v${PYSTON_VERSION} \
 && git submodule update --init --recursive build_deps \
 && make llvm_up && make pyston_release \
 && mv build/Release /opt/pyston \
 && cd .. && rm -R pyston \
 && cd /usr/local/bin && ln -s /opt/pyston/pyston pyston \
 && DEBIAN_FRONTEND=noninteractive apt-get -yq --purge autoremove $build_deps \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
