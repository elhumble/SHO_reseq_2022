#!/bin/sh
#$ -N realSFShet
#$ -cwd
#$ -l h_rt=1:00:00
#$ -l h_vmem=8G
#S -pe sharedmem 4
#$ -t 1-29
#$ -o o_files
#$ -e e_files

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/angsd/
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/ind_het_ml

#~~~ array within an array

SAMPLE=`echo $1`
base=`echo $1 | awk '{print $1}' | cut -f 14 -d '/' | cut -f 1 -d '.' | cut -f 1 -d '_'`
echo Processing ${SAMPLE} and ${base}

$SOFTWARE_DIR/misc/realSFS $TARGET_DIR/${base}_${SGE_TASK_ID}.saf.idx -win 2500000 -step 2500000 > $TARGET_DIR/${base}_${SGE_TASK_ID}_est.ml

