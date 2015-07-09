FROM ubuntu

ENV PYTHONS="python2.3 python2.4 python2.5 python2.6 python2.7 python3.1 python3.2 python3.3 python3.4 pypy"

RUN apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qy \
        curl jupp nano vim software-properties-common \
 && add-apt-repository -y ppa:fkrull/deadsnakes \
 && apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qy $PYTHONS \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

 RUN version=3-2.4 \
  && mkdir /opt/pypy3 \
  && curl -LOsS "https://bitbucket.org/squeaky/portable-pypy/downloads/pypy${version}-linux_x86_64-portable.tar.bz2" \
  && tar xfj /pypy${version}-linux_x86_64-portable.tar.bz2 -C /opt/pypy3 \
  && rm /*.tar.bz2 \
  && ln -s /opt/pypy3/pypy3-*/bin/pypy3 /usr/local/bin/pypy3

RUN curl -OsS https://bootstrap.pypa.io/get-pip.py \
 && versions="2.6 2.7 3.2 3.3 3.4" \
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
    && rm easy_install pip2 pip3 wheel
