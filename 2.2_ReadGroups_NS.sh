#!/bin/sh
# Grid Engine options
#$ -N add_RG
#$ -cwd
#$ -l h_rt=8:00:00
#$ -l h_vmem=4G
#$ -pe sharedmem 4
#$ -t 1-180
#$ -o o_files
#$ -e e_files

# Jobscript to add read groups

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

SCRATCH=/exports/eddie/scratch/ehumble
INPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/bwa

# Get list of files in target directory

bam=$(ls -1 ${INPUT_DIR}/*mapped_sorted.bam)

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

this_bam=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p)
echo Processing file: ${this_bam} on $HOSTNAME

RGID=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p | cut -f 13 -d '/' | cut -f 2,3 -d '_')
RGPU=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p | cut -f 13 -d '/' | cut -f 1,2,3 -d '_')
RGSM=$(echo "${bam}" | sed -n ${SGE_TASK_ID}p | cut -f 13 -d '/' | cut -f 1 -d '_')

echo $RGID $RGPU $RGSM

java -Xmx4g -jar /exports/cmvm/eddie/eb/groups/ogden_grp/software/picard/picard.jar AddOrReplaceReadGroups \
	I=$this_bam \
       	O=${this_bam%.bam}_RG.bam \
       	RGID=$RGID \
        RGPL=illumina \
        RGLB=lib2 \
        RGPU=$RGPU \
        RGSM=$RGSM \
        VALIDATION_STRINGENCY=SILENT \
        SORT_ORDER=coordinate \
        TMP_DIR=$SCRATCH

# RGID = 2,3 e.g. 200821_2
# RGPL = illumina
# RGLB = Lib2
# RGPU = 1,2,3 e.g. MSH063_200124_1
# RGSM = 1 e.g. MSH063
