#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

if [ "$SKIP_PA" ] ; then
    echo 1>&2 '# Skipping presence/absence analysis'
    exit
fi


# ------------------------------------------------------------------------

rm -rf ${PA}
mkdir -p ${PA}

# ------------------------------------------------------------------------
# Run presence/absence analysis
# ------------------------------------------------------------------------

echo 1>&2 '# Run presence/absence analysis'

if [ -z "${REPLICON_NAMES}" ] ; then
    REPLICON_NAMES=/dev/null
fi

cat ${REPLICON_NAMES} \
    | sed -e 's/ *#.*//' \
    | grep -v '^$/' \
    | tr '\t' '\a' \
    | (
    while IFS=$'\a' read OLD NEW ; do
	echo "s/\<$OLD\>/$NEW/g"
    done
) > ${PA}/names.sed


cat ${ROARY}/gene_presence_absence.Rtab \
    | sed -f ${PA}/names.sed \
	  > ${PA}/gene_presence_absence.Rtab

Rscript $(dirname $0)/$(basename $0 .bash).R ${PA}


# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

