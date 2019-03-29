# Nest of serpents

![image](http://i2.mirror.co.uk/incoming/article2357510.ece/ALTERNATES/s1200/The-Monty-Python-team-imitate-journalist-and-broadcaster-Alan-Whicker.jpg)

This repo provides two Ubuntu-derived image that have the following interpreters
installed. (They are distributed to different images due to limitations in the
Docker hub's automated build system.)

###### `funkyfuture/nest-of-serpents:latest`

  - CPython 2
    - `python2.3` (2.3.7)
    - `python2.4` (2.4.6)
    - `python2.5` (2.5.6)
    - `python2.6` (2.6.9) w/ `pip` 9.0.3 & `setuptools` 36.6
    - `python2.7` (2.7.15-rc1) w/ latest `pip`, `setuptools` & `wheel`
  - CPython 3
    - `python3.1` (3.1.5) w/ `pip` 1.5.6 & `setuptools` 3.8
    - `python3.2` (3.2.6) w/ `pip` 7.1.2 & `setuptools` 7.1
    - `python3.3` (3.3.7) w/ `pip` 10.0.1 & `setuptools` 7.1
    - `python3.4` (3.4.9) w/ latest `pip`, `setuptools` & `wheel`
    - `python3.5` (3.5.6) w/ latest `pip`, `setuptools` & `wheel`
    - `python3.6` (3.6.8) w/ latest `pip`, `setuptools` & `wheel`
    - `python3.7` (3.7.3) w/ latest `pip`, `setuptools` & `wheel`
    - `python3.8` (3.8.0-a3)
  - PyPy
    - `pypy2.7` (7.0.0)
    - `pypy3.5` (7.0.0)

###### `funkyfuture/nest-of-serpents:pyston`

As unfortunately the Pyston development was stopped, there will be no further
builds of this image.

  - most from `:latest` (though versions are partly outdated)
  - Pyston
    - `pyston` (0.6)

Their sources are
[Felix Krull's Deadsnakes PPA](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa),
the [Pyston sources](https://github.com/dropbox/pyston),
and [PyPy's builds](http://pypy.org/download.html).

The images are supposed to be a base for testing Python-code against historical
and most recent interpreters. Some further tools for are on board, see below.

### pip

The scripts to invoke `pip` have the CPython interpreter's version as suffix,
e.g. `pip2.6`, for PyPy suffix is `-pypy` followed by the version number, e.g.
`pip-pypy2.7`.
For Pyston there's `pyston-pip`, note that this installs executables to
`/opt/pyston/bin`.

You may use the `PIP_INDEX_URL` environment variable to use a
[PyPI-cache](http://doc.devpi.net/latest/quickstart-pypimirror.html).

### Other tools

These tools are installed additionally to those from the Ubuntu-image:
`bzip2`, `curl`, `g++`, `gcc`, `git`, `jupp`, `less`, `make`, `nano` `time`,
`vim`, `unzip`, `xz` and its friends.

Feel free to request further tools that are useful in general to be included.


###### Docker Hub repository

https://registry.hub.docker.com/u/funkyfuture/nest-of-serpents/

###### Source repository

https://github.com/funkyfuture/docker-nest-of-serpents


## TODO

- add CPython 2.0, 2.1, 2.2, 3.0
