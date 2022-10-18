#!/bin/sh
# Grid Engine options
#$ -N down_bam
#$ -cwd
#$ -l h_rt=8:00:00
#$ -l h_vmem=6G
#$ -t 1-20
#$ -R y
#$ -o o_files
#$ -e e_files

# Jobscript to downsample high coverage rmdup bam files

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

INPUT_DIR="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/HS"
OUTPUT_DIR="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/HS/downsample"
COVERAGE="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/proportion_to_downsample.txt"

# Load samtools
module load roslin/samtools/1.9 

# Bam files for array job

BAM=`ls $INPUT_DIR/*rmdup.bam`

THIS_BAM=$(echo "${BAM}" | sed -n ${SGE_TASK_ID}p)
base=

echo Processing $THIS_BAM

# Proportion to downsample for array job

PROP=`sed -n "${SGE_TASK_ID}"p $COVERAGE | awk '{print $2}'`


echo At this proportion: $PROP

samtools view -s $PROP -b $THIS_BAM > ${THIS_BAM%.bam}_downsample.bam

