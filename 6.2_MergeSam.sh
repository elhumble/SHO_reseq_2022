#!/bin/sh
# Grid Engine options
#$ -N MergeSam
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=12G
#S -pe sharedmem 4
#$ -R y
#$ -o o_files
#$ -e e_files

# Jobscript to Merge bam files

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java

# Specifiy some variables

SCRATCH=/exports/eddie/scratch/ehumble
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/bam

cd $TARGET_DIR
file=$(ls *mapped_sorted.bam)

bamlist=$(for f in $file; do echo -n "I=$f " ; done)
echo $bamlist

java -Xmx8g -jar /exports/cmvm/eddie/eb/groups/ogden_grp/software/picard/picard.jar MergeSamFiles \
       $bamlist \
       O=outgroup_merged.bam \
       TMP_DIR=$SCRATCH

