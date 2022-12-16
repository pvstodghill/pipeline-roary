#! /bin/bash

set -e

NAME=pipeline-roary

CONDA_PREFIX=$(dirname $(dirname $(type -p conda)))
. "${CONDA_PREFIX}/etc/profile.d/conda.sh"

PACKAGES=
#PACKAGES+=" pip"

PACKAGES+=" fasttree"
PACKAGES+=" kraken"
PACKAGES+=" r-ggplot2"
PACKAGES+=" roary"

if [ "$(type -p mamba)" ] ; then
    _conda="mamba --no-banner"
else
    _conda=conda
fi

if [ "$1" = -f -o ! -d ${CONDA_PREFIX}/envs/${NAME} ] ; then
    (
	set -x
	conda env remove -y --name ${NAME}
	conda create -y --name ${NAME}
    )
fi

echo + conda activate ${NAME}
conda activate ${NAME}

set -x

$_conda install -y ${PACKAGES}

#pip install FIXME
