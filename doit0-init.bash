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

fasta_notice=
for f in ${GENOMES_DIR}/*${GENOMES_EXT} ; do
    name="$(basename "$f" ${GENOMES_EXT})"
    cp --archive "$f" ${INPUTS}/"$name".gff
    if ( egrep -ls '^##FASTA' ${INPUTS}/"$name".gff ) ; then
	: nothing - gff already includes .fna
    else
	# annotations not produced by prokka. Add the sequence to the
	# end of the .gff file.
	if [ -z "$fasta_notice" ] ; then
	    echo 1>&2 "## Adding FASTA along the way"
	    fasta_notice=1
	fi
	echo '##FASTA' >> ${INPUTS}/"$name".gff
	cat ${GENOMES_DIR}/${name}.fna >> ${INPUTS}/"$name".gff
    fi
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

