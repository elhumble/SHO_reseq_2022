#!/bin/sh
# Grid Engine options
#$ -N MarkDups
#$ -cwd
#$ -l h_rt=10:00:00
#$ -l h_vmem=8G
#$ -pe sharedmem 4
#$ -t 1-20
#$ -R y
#$ -o o_files
#$ -e e_files
#$ -M emily.humble@ed.ac.uk

# Jobscript to rmdup

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

SCRATCH=/exports/eddie/scratch/ehumble
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/HS

# Get list of files in target directory

bam=$(ls -1 ${TARGET_DIR}/*RG.bam)

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

this_bam=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p)
echo Processing file: ${this_bam} on $HOSTNAME

base=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p | cut -f 14 -d '/' | cut -f 1 -d '.' | cut -f 1 -d '_')

java -Xmx10g -jar /exports/cmvm/eddie/eb/groups/ogden_grp/software/picard/picard.jar MarkDuplicates \
       I=$this_bam \
       O=${this_bam%.bam}_rmdup.bam \
       METRICS_FILE=${this_bam%.bam}_rmdup.metrics \
       ASSUME_SORTED=true \
       REMOVE_DUPLICATES=true \
       VALIDATION_STRINGENCY=SILENT \
       TMP_DIR=$SCRATCH \
       MAX_SEQUENCES_FOR_DISK_READ_ENDS_MAP=50000 \
       MAX_RECORDS_IN_RAM=50000

