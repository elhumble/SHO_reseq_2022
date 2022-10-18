#!/bin/sh
# Grid Engine options
#$ -N IndexRef
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=16G
#S -pe sharedmem 4
#$ -o o_files
#$ -e e_files

# Jobscript to index reference

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load samtools
module add roslin/samtools/1.9
module add roslin/bwa/0.7.17

REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna

# index ref with both bwa and samtools for mapping and SNP calling with samtools

samtools faidx $REFERENCE
bwa index $REFERENCE
