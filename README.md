# Deadsnakes

An Ubuntu-derived image that has these interpreters installed:

  - CPython 2
    - `python2.3` (2.3.7)
    - `python2.4` (2.4.6)
    - `python2.5` (2.5.6)
    - `python2.6` (2.6.9)
    - `python2.7` (2.7.10)
  - CPython 3
    - `python3.1` (3.1.5)
    - `python3.2` (3.2.6)
    - `python3.3` (3.3.6)
    - `python3.4` (3.4.3)
    - `python3.5` (3.5.0)
  - PyPy
    - `pypy` (4.0.0)
    - `pypy3` (2.4.0)

Their sources are
[Felix Krull's Deadsnakes PPA](https://launchpad.net/~fkrull/+archive/ubuntu/deadsnakes),
the [Python sources](https://www.python.org/ftp/python/),
the [PyPy developer's ppa](https://launchpad.net/~pypy/+archive/ubuntu/ppa),
and
[Squeaky's portable PyPy-builds](https://github.com/squeaky-pl/portable-pypy).

The image is supposed to be a base for testing Python-code against historical
and most recent interpreters. Some further tools for are on board, see below.

### pip

The latest `pip` available at build is installed for versions 2.6, 2.7, 3.2,
3.4, 3.4 and 3.5. Those for PyPy are called `pyp` respectively `pyp3`.

You may use the `PIP_INDEX_URL` environment variable to use a
[PyPI-cache](http://doc.devpi.net/latest/quickstart-pypimirror.html).

### Other tools

These tools are installed additionally to those from the Ubuntu-image:
`curl`, `gcc`, `jupp`, `make`, `nano` and `vim`.

Feel free to request further tools that are useful in general to be included.


###### Docker Hub repository

https://registry.hub.docker.com/u/funkyfuture/nest-of-serpents/

###### Source repository

https://github.com/funkyfuture/docker-nest-of-serpents


## TODO

- add CPython 2.0, 2.1, 2.2, 3.0
- implement mechanics to link a devpi-container
- dig out pip-versions that are compatible with 2.3, 2.4, 2.5 and 3.1
