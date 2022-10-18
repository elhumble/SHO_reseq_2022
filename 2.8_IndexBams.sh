#!/bin/sh
# Grid Engine options
#$ -N IndexBam
#$ -cwd
#$ -l h_rt=2:00:00
#$ -l h_vmem=4G
#S -pe sharedmem 4
#$ -t 1-20
#$ -o o_files
#$ -e e_files
#$ -M emily.humble@ed.ac.uk
#$ -m beas

# Jobscript to index bams
# Run separately for HS / NS / DS

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add roslin/samtools/1.9

# Specify some paths

#TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/HS
#TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/NS
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/HS/downsample

# Get list of files in target directory

#bam=$(ls -1 ${TARGET_DIR}/*rmdup.bam)
bam=$(ls -1 ${TARGET_DIR}/*downsample.bam)

# Get the file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

this_bam=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p)
echo Processing file: ${this_bam} on $HOSTNAME

# index bams

samtools index ${this_bam}

