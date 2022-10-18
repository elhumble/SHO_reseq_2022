#!/bin/sh
# Grid Engine options
#$ -N sort_sam
#$ -cwd
#$ -l h_rt=16:00:00
#$ -l h_vmem=8G
#$ -pe sharedmem 4
#S -t 1-20
#$ -R y
#$ -o o_files
#$ -e e_files
#$ -M emily.humble@ed.ac.uk
#$ -m beas

# Jobscript to sort bam files
# Run for HS and NS separately

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/HS
SCRATCH=/exports/eddie/scratch/ehumble

# Get list of files in target directory

bam=$(ls -1 ${TARGET_DIR}/*mapped.bam)

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

#this_bam=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p)
#echo Processing file: ${this_bam} on $HOSTNAME

#mkdir $SCRATCH/data/out

#BASE=$(echo "$this_bam")

#echo Saving file ${BASE} on $TARGET_DIR 

java -Xmx4g -jar /exports/cmvm/eddie/eb/groups/ogden_grp/software/picard/picard.jar SortSam \
       I=$this_bam \
       O=${BASE%.bam}_sorted.bam \
       SORT_ORDER=coordinate \
       TMP_DIR=$SCRATCH


