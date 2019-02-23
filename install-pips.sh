#!/bin/bash

set -ex

WHEEL=/usr/local/bin/wheel

function install_latest {
  eval python${1} get-pip.py
  mv ${WHEEL} ${WHEEL}${1}
}

function install_obsolete {

  local python=python${1}

  if [ ! "$(eval ${python} -c \'import importlib\')" ]; then
    cd importlib
    eval ${python} setup.py install
    cd -
  fi

  if [ ! "$(eval ${python} -c \'import setuptools\')" ]; then
    cd setuptools
    git checkout ${3}
    [ -f bootstrap.py ] && eval ${python} bootstrap.py
    eval ${python} setup.py install
    git reset --hard
    find . -name "*.pyc" -delete
    cd -
  fi

  cd pip
  git checkout ${2}
  eval ${python} setup.py install
  cd -

}

curl -OsS https://bootstrap.pypa.io/get-pip.py

install_latest 2.7
install_latest 3.4
install_latest 3.5  # up to pip 19.1
install_latest 3.6
install_latest 3.7
# install_latest 3.8

pypy2.7 get-pip.py
pypy3.5 get-pip.py

for pip_script in /opt/pypy*/bin/pip; do
  ln -s ${pip_script} /usr/local/bin/pip-${pip_script:5:7}
done

curl -OsS https://files.pythonhosted.org/packages/31/77/3781f65cafe55480b56914def99022a5d2965a4bb269655c89ef2f1de3cd/importlib-1.0.4.zip
unzip *.zip
mv importlib-1.0.4 importlib
git clone https://github.com/pypa/pip.git
git clone https://github.com/pypa/setuptools.git

install_obsolete 2.6  9.0.3 cb9e3a35bfc07136c44d942698fc45fc3f12192b
install_obsolete 3.1  1.5.6 846b29f32fb8bbeda4d4a06a4da35bebc3f41cbb
install_obsolete 3.2  7.1.2 8772accf84d424f6cc848567fde0747716448030
install_obsolete 3.3 10.0.1 8772accf84d424f6cc848567fde0747716448030

cd /usr/local/bin
rm easy_install pip
