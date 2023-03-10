#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------

rm -rf ${ROARY}

# ------------------------------------------------------------------------
# Run Roary
# ------------------------------------------------------------------------

echo 1>&2 '# Run Roary'
roary -v -e -mafft ${ROARY_ARGS} -p ${THREADS} -f ${ROARY}/ -r ${INPUTS}/*.gff

if [ ! -e ${ROARY}/core_gene_alignment.aln ] ; then
    echo 1>&2 "## Roary failed."
    exit 1
fi

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

