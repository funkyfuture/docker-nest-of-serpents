FROM ubuntu:xenial

RUN pythons="python2.3 python2.4 python2.5 python2.6 python3.1 python3.2 python3.3 python3.4" \
 && apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends \
        bzip2 curl gcc git jupp make nano vim software-properties-common time xz-utils \
        libncurses5-dev libreadline-dev libsqlite3-dev libssl-dev zlib1g-dev \
 && add-apt-repository -y ppa:fkrull/deadsnakes \
 && apt-get -q update \
 && apt-get -qy upgrade \
 && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends $pythons \
 && apt-get autoremove --purge -qy software-properties-common \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

 RUN for version in 2.7.12 3.5.2 3.6.0b2 ; do \
         dir=$(echo $version | sed "s/[ab][0-9]$//") \
      && curl -sOLS "https://www.python.org/ftp/python/${dir}/Python-$version.tar.xz" \
      && tar xf Python-${version}.tar.xz \
      && cd Python-${version} \
      && ./configure \
      && make \
      && make altinstall \
      && cd - \
      && rm -Rf /Python-${version} \
      && rm Python-${version}.tar.xz ; \
    done

 RUN for pypy in pypy2-v5.3.1 pypy3.3-v5.2.0-alpha1 ; do \
       pypy_archive="${pypy}-linux64.tar.bz2" && \
       pypy_name="$(echo $pypy | cut -f1 -d-)" && \
       pypy_target="/opt/${pypy_name}" && \
       curl -LOsS "https://bitbucket.org/pypy/pypy/downloads/${pypy_archive}" && \
       tar xfj $pypy_archive -C /opt && \
       mv "/opt/${pypy}-linux64" $pypy_target && \
       rm $pypy_archive && \
       ln -s ${pypy_target}/bin/pypy* /usr/local/bin ; \
     done \
 && cd /usr/local/bin && ln -s pypy pypy2

RUN curl -OsS https://bootstrap.pypa.io/get-pip.py \
 && versions="2.6 2.7 3.3 3.4 3.5 3.6" \
 && for version in $versions; do \
      eval python$version get-pip.py && \
      mv /usr/local/bin/wheel /usr/local/bin/wheel$version; \
    done \
 && pypy2 get-pip.py \
 && pypy3.3 get-pip.py \
 && rm get-pip.py \
 && cd /usr/local/bin \
    && cp pip pyp3.3 && mv pip pyp2 && ln -s pyp2 pyp \
    && sed -i -e 's_/usr/bin/pypy_/usr/local/bin/pypy3_g' pyp3.3 \
    && rm easy_install pip2 pip3
