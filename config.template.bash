# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

GENOMES_DIR=/.../data/6_final
GENOMES_EXT=.gff+fna

# # Genomes to remove before processing
# OUTGROUPS=
# OUTGROUPS+=" Name1"
# OUTGROUPS+=" Name2"

# # a tab-delimed file for replicon name substitutions (*cough* Prokka *cough*)
# # - column 1: replicon name as it appears in input genomes
# # - column 2: replicon name as it should appear in the output
# REPLICON_NAMES=local/names.txt

# ------------------------------------------------------------------------

# ROARY_ARGS="-g 60000" # increase the max number of clusters from 50000.

# ------------------------------------------------------------------------

# SKIP_FASTTREE=1 # don't run FastTreeMP
# SKIP_PA=1 # don't run presence/absence analysis

# ------------------------------------------------------------------------

# Uncomment to get packages from HOWTO
PACKAGES_FROM=howto

# # Uncomment to use conda
# PACKAGES_FROM=conda
# CONDA_ENV=pipeline-roary

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------
