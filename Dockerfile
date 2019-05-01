FROM ubuntu:bionic

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN apt-get -q update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends \
        software-properties-common \
        build-essential bzip2 ca-certificates curl git jupp less nano netbase vim time unzip xz-utils \
 && add-apt-repository -y ppa:deadsnakes/ppa \
 && apt-get -q update \
 && apt-get -qy upgrade \
 && DEBIAN_FRONTEND=noninteractive apt-get -qy install --no-install-recommends "^python[23]\.[0-9]$" \
 && apt-get autoremove --purge -qy software-properties-common \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN for pypy in pypy2.7-v7.0.0 pypy3.5-v7.0.0 pypy3.6-v7.1.1 ; do \
       pypy_archive="${pypy}-linux64.tar.bz2" && \
       pypy_name="$(echo $pypy | cut -f1 -d-)" && \
       pypy_target="/opt/${pypy_name}" && \
       curl -LOsS "https://bitbucket.org/pypy/pypy/downloads/${pypy_archive}" && \
       tar xfj $pypy_archive -C /opt && \
       mv "/opt/${pypy}-linux64" $pypy_target && \
       rm $pypy_archive ; \
     done \
 && ln -s /opt/pypy2.7/bin/pypy /usr/local/bin/pypy2.7 \
 && ln -s /opt/pypy3.5/bin/pypy3 /usr/local/bin/pypy3.5 \
 && ln -s /opt/pypy3.6/bin/pypy3 /usr/local/bin/pypy3.6

COPY install-pips.sh /tmp/
RUN cd /tmp  \
 && ./install-pips.sh \
 && rm -Rf *
