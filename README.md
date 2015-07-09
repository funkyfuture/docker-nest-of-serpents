# Deadsnakes

An Ubuntu-derived image that has these interpreters installed:

  - CPython 2
    - `python2.3` (2.3.7)
    - `python2.4` (2.4.6)
    - `python2.5` (2.5.6)
    - `python2.6` (2.6.9)
    - `python2.7` (2.7.6)
  - CPython 3
    - `python3.1` (3.1.5)
    - `python3.2` (3.2.6)
    - `python3.3` (3.3.6)
    - `python3.4` (3.4.0)
  - PyPy
    - `pypy` (2.2.1)
    - `pypy3` (2.4.0)

Their sources are the [Ubuntu-repositories](http://packages.ubuntu.com/trusty/python/),
[Felix Krull's Deadsnakes PPA](https://launchpad.net/~fkrull/+archive/ubuntu/deadsnakes)
and
[Squeaky's portable PyPy-builds](https://github.com/squeaky-pl/portable-pypy).

### pip

The latest `pip` available at build is installed for versions 2.6, 2.7, 3.2,
3.4 and 3.4. Those for PyPy are called `pyp` respectively `pyp3`

You may use the `PIP_INDEX_URL` environment variable to use a
[PyPI-cache](http://doc.devpi.net/latest/quickstart-pypimirror.html).

###### Docker Hub repository


https://registry.hub.docker.com/u/funkyfuture/nest-of-serpents/


###### Source repository

https://github.com/funkyfuture/docker-nest-of-serpents


## TODO

- install latest Python 2.7 & 3.4
- implement mechanics to link a devpi-container
- dig out pip-versions that are compatible with 2.3, 2.4, 2.5 and 3.1
