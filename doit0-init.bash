#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Set up
# ------------------------------------------------------------------------

if [ -d ${DATA} ] ; then
    echo 1>&2 "# Removing ${DATA}. Hope that's what you wanted"
    rm -rf ${DATA}
fi

echo 1>&2 "# Initializing ${DATA}/..."
rm -rf ${DATA}/tmp
mkdir -p ${DATA}/tmp

# ------------------------------------------------------------------------
# Collecting input files
# ------------------------------------------------------------------------

echo 1>&2 "# Collecting input files..."
rm -rf ${INPUTS}
mkdir -p ${INPUTS}

if [ -z ${GENOMES_EXT} ] ; then
    GENOMES_EXT=.gff+fna
fi

for f in ${GENOMES_DIR}/*${GENOMES_EXT} ; do
    name="$(basename "$f" ${GENOMES_EXT})"
    cp --archive "$f" ${INPUTS}/"$name".gff
done

# ------------------------------------------------------------------------
# Removing outgroups
# ------------------------------------------------------------------------

if [ "${OUTGROUPS}" ] ; then
    echo 1>&2 "# Removing outgroups..."
    for name in ${OUTGROUPS} ; do
	rm -f ${INPUTS}/"$name".gff
    done
fi

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 ''
echo 1>&2 '# Done.'

