# Deadsnakes

An Ubuntu-derived image that has Python2.3, Python2.4, Python2.5, Python2.6,
Python3.1, Python3.2 and Python3.3 installed from [Felix Krull's Deadsnakes PPA](https://launchpad.net/~fkrull/+archive/ubuntu/deadsnakes).

The current *pip* is installed for versions 2.6, 3.2 and 3.3.

You may use the `PIP_INDEX_URL` environment variable to use a [PyPI-cache](http://doc.devpi.net/latest/quickstart-pypimirror.html).

## TODO

- implement mechanics to link a devpi-container
- dig out pip-versions that are compatible with 2.3, 2.4, 2.5 and 3.1
