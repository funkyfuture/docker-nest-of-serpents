FROM funkyfuture/nest-of-serpents

ENV PYSTON_VERSION=0.6
RUN build_deps="automake cmake libtool ninja-build pkg-config ccache clang libbz2-dev libffi-dev libgmp3-dev liblzma-dev libmpfr-dev python-dev" \
 && apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends $build_deps \
 && cd /root && mkdir .ccache && touch .ccache/ccache.conf \
 && git config --global user.name "nest-of-serpents" \
 && git config --global user.email "funkyfuture+nest-of-serpents@hub.docker.com" \
 && git clone https://github.com/dropbox/pyston.git \
 && git clone https://github.com/llvm-mirror/llvm.git pyston_deps/llvm-trunk \
 && git clone https://github.com/llvm-mirror/clang.git pyston_deps/llvm-trunk/tools/clang \
 && cd pyston \
 && git checkout v${PYSTON_VERSION} \
 && git submodule update --init --recursive build_deps \
 && make llvm_up && make pyston_release \
 && mkdir /opt/pyston && cd build/Release \
 && mv pyston lib include /opt/pyston \
 && rm -R /root/pyston /root/pyston_deps /root/.ccache \
 && ln -s /opt/pyston/pyston /usr/local/bin/pyston \
 && DEBIAN_FRONTEND=noninteractive apt-get -yq --purge autoremove $build_deps \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && cd / && curl -O https://bootstrap.pypa.io/get-pip.py \
 && pyston get-pip.py \
 && rm get-pip.py \
 && ln -s /opt/pyston/bin/pip /usr/local/bin/pyston-pip \
 && echo -e "\nexport PATH=$PATH:/opt/pyston/bin\n" >> /root/.bashrc
