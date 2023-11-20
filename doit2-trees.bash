#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

if [ "$SKIP_FASTTREE" ] ; then
    echo 1>&2 '# Skipping FastTreeMP'
    exit
fi


# ------------------------------------------------------------------------

rm -rf ${TREES}
mkdir -p ${TREES}

# ------------------------------------------------------------------------
# Run FastTreeMP
# ------------------------------------------------------------------------

echo 1>&2 '# Run FastTreeMP'
export OMP_NUM_THREADS=${THREADS}
FastTreeMP -nt -gtr ${ROARY}/core_gene_alignment.aln > ${TREES}/tree.phy


# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

