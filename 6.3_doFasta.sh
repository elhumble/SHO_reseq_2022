#!/bin/sh
# Grid Engine options
#$ -N doFasta
#$ -cwd
#$ -l h_rt=12:00:00
#$ -l h_vmem=12G
#$ -pe sharedmem 6
#$ -o o_files
#$ -e e_files

# Jobscript to get gls from bams with angsd

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/angsd/
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/bam
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest

# Run process

# Get consensus fasta from merged ba,

$SOFTWARE_DIR/angsd \
	-i $TARGET_DIR/outgroup_merged.bam \
	-P 4 \
	-doFasta 2 \
	-doCounts 1 \
	-out $OUTPUT_DIR/outgroup_consensus.fasta


