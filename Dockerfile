FROM ubuntu:trusty

RUN pythons="python2.3 python2.4 python2.5 python2.6 python2.7 python3.1 python3.2 python3.3 python3.5" \
 && apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qy \
        curl jupp nano vim software-properties-common \
        gcc libncurses5-dev libreadline-dev libsqlite3-dev libssl-dev make zlib1g-dev \
 && add-apt-repository -y ppa:fkrull/deadsnakes \
 && add-apt-repository -y ppa:fkrull/deadsnakes-python2.7 \
 && apt-get purge -qy software-properties-common \
 && apt-get -q update \
 && apt-get -qy upgrade \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qy $pythons \
 && apt-get autoremove -qy \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

 RUN for version in 3.4.4 3.6.0a1 ; do \
         dir=$(echo $version | sed "s/a1$//") \
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

 RUN for pypy in pypy-5.0.1 pypy3-2.4.0 ; do \
       pypy_archive="${pypy}-linux64.tar.bz2" && \
       pypy_name="$(echo $pypy | cut -f1 -d-)" && \
       pypy_target="/opt/${pypy_name}" && \
       curl -LOsS "https://bitbucket.org/pypy/pypy/downloads/${pypy_archive}" && \
       tar xfj $pypy_archive -C /opt && \
       mv "/opt/${pypy}-linux64" $pypy_target && \
       rm $pypy_archive && \
       ln -s "${pypy_target}/bin/${pypy_name}" "/usr/local/bin/${pypy_name}"; \
     done

RUN curl -OsS https://bootstrap.pypa.io/get-pip.py \
 && versions="2.6 2.7 3.3 3.4 3.5 3.6" \
 && for version in $versions; do \
      eval python$version get-pip.py && \
      mv /usr/local/bin/wheel /usr/local/bin/wheel$version; \
    done \
 && pypy get-pip.py \
 && pypy3 get-pip.py \
 && rm get-pip.py \
 && cd /usr/local/bin \
    && cp pip pyp3 && mv pip pyp \
    && sed -i -e 's_/usr/bin/pypy_/usr/local/bin/pypy3_g' pyp3 \
    && rm easy_install pip2 pip3
