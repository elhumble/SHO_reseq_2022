#!/bin/sh
# Grid Engine options
#$ -N bamcov
#$ -cwd
#$ -l h_rt=8:00:00
#$ -l h_vmem=4G
#$ -pe sharedmem 4
#$ -t 1-20
#$ -R y
#$ -o o_files
#$ -e e_files

# Jobscript to estimate read depth in bam files
# Edit paths for DS / NS

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add roslin/samtools/1.10

TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/DS

# Get list of files in target directory

bam=$(ls -1 ${TARGET_DIR}/*.bam)

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

this_bam=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p)
echo Processing file: ${this_bam} on $HOSTNAME

base=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p | cut -f 7 -d '/' | cut -f 1 -d '.' | cut -f 1 -d '_')

#samtools depth -aa $this_bam | cut -f 3 | gzip > ${this_bam%.bam}_depth.gz

samtools coverage $this_bam | gzip > ${this_bam%.bam}_cov.gz

