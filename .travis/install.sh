#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" == 'Darwin' ]]; then
    brew update || brew update
    brew outdated pyenv || brew upgrade pyenv
    brew install pyenv-virtualenv
    brew install cmake || true

    if [[ "${CONAN_APPLE_CLANG_VERSIONS}" == "10.0" ]]; then
        brew link gcc
    elif [[ "${CONAN_APPLE_CLANG_VERSIONS}" == "7.3" ]]; then
        brew install gcc
    fi

    if which pyenv > /dev/null; then
        eval "$(pyenv init -)"
    fi

    pyenv install 2.7.10
    pyenv virtualenv 2.7.10 conan
    pyenv rehash
    pyenv activate conan
fi

pip install conan --upgrade
pip install conan_package_tools

conan user
