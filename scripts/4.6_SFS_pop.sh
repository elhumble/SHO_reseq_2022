#!/bin/sh
#$ -N doSaf
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=16G
#$ -pe sharedmem 2
#$ -R y
#$ -t 1-29
#$ -e e_files
#$ -o o_files

# Preparing for ANGSD doThetas at pop level

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/angsd/
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/sfs
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna

SCAFF_LIST=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/scaff_IDs

# Get chr to be processed by *this* task
# Genic SNPs for -rf

#GENIC=`ls $TARGET_DIR/NW_*`
#THIS_GENIC=$(echo "${GENIC}" | sed -n ${SGE_TASK_ID}p)

SCAFF=`sed -n "$SGE_TASK_ID"p $SCAFF_LIST | awk '{print $1}'`
echo $SCAFF

# Get list of bamfile lists in target directory

pop_file=`echo $1`

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

echo Processing files: ${pop_file} on $HOSTNAME

bams=`echo $pop_file | cut -f 2 -d '/'`

base=`echo $pop_file | cut -f 2 -d '/' | cut -f 1 -d '_'`

echo Also processing base: ${base}

# Find global estimate of SFS for each pop and species

echo Finding global estimate of SFS...

$SOFTWARE_DIR/angsd \
	-P 2 \
       	-b $pop_file \
        -ref $REFERENCE \
	-r $SCAFF \
        -anc $REFERENCE\
        -out $OUTPUT_DIR/${base}_${SGE_TASK_ID} \
        -uniqueOnly 1 \
        -remove_bads 1 \
        -only_proper_pairs 1 \
        -trim 0 \
        -C 50 \
        -baq 1 \
        -minMapQ 30 \
        -minQ 30 \
        -doCounts 1 \
        -GL 1 \
        -doSaf 1 \
        -fold 1

# -setMaxDepth 368
# -rf $THIS_GENIC

# Get the ML estimate of SFS for each pop and sp

echo Calculating maximum likelihood estimate of the SFS...

$SOFTWARE_DIR/misc/realSFS $OUTPUT_DIR/${base}_${SGE_TASK_ID}.saf.idx > $OUTPUT_DIR/${base}_${SGE_TASK_ID}.sfs
