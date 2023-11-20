#! /bin/bash

set -e

NAME=pipeline-roary
if [ "${TARGET_CONDA_ENV}" ] ; then
    NAME="${TARGET_CONDA_ENV}"
fi

CONDA_PREFIX=$(dirname $(dirname $(type -p conda)))
. "${CONDA_PREFIX}/etc/profile.d/conda.sh"

PACKAGES=
#PACKAGES+=" pip"

PACKAGES+=" fasttree"
PACKAGES+=" kraken"
PACKAGES+=" roary"
PACKAGES+=" r-ape"

if [ "$(type -p mamba)" ] ; then
    _conda="mamba --no-banner"
else
    _conda=conda
fi

function __ {
    echo + "$@"
    eval "$@"
}

if [ "$1" = -f ] ; then
    __ conda env remove -y --name ${NAME}
fi

_install=update
if [ ! -d ${CONDA_PREFIX}/envs/${NAME} ] ; then
    __ $_conda create -y --name ${NAME}
    __ $_conda config --add channels r
    __ $_conda config --add channels defaults
    __ $_conda config --add channels conda-forge
    __ $_conda config --add channels bioconda
    _install=install
fi

__ conda activate ${NAME}


__ $_conda $_install -y --no-channel-priority ${PACKAGES}

# __ pip $_install FIXME

