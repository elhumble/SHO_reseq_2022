#!/bin/sh
# Grid Engine options
#$ -N SeqDictionary
#$ -cwd
#$ -l h_rt=2:00:00
#$ -l h_vmem=8G
#S -pe sharedmem 4
#$ -o o_files
#$ -e e_files

# Jobscript to create sequence dictionary

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java

# Specifiy some paths

PICARD_PATH=/exports/cmvm/eddie/eb/groups/ogden_grp/software/picard
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna

# Run Picard

java -Xmx4G -jar $PICARD_PATH/picard.jar CreateSequenceDictionary \
      R=$REFERENCE \
      O=${REFERENCE%.fasta}.dict
