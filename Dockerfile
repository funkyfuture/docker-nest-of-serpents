FROM ubuntu

ENV PYTHONS="python2.3 python2.4 python2.5 python2.6 python3.1 python3.2 python3.3"

RUN apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qy \
        curl jupp nano vim software-properties-common \
 && add-apt-repository -y ppa:fkrull/deadsnakes \
 && apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qy $PYTHONS \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -OsS https://bootstrap.pypa.io/get-pip.py \
 && versions="2.6 3.2 3.3" \
 && for version in $versions; do \
      eval python$version get-pip.py && \
#      mv /usr/local/bin/easy_install /usr/local/bin/easy_install$version; \
      mv /usr/local/bin/wheel /usr/local/bin/wheel$version; \
    done \
 && rm get-pip.py \
 && cd /usr/local/bin && rm easy_install pip pip2 pip3
