#!/bin/sh
# Grid Engine options
#$ -N vcf2bed
#$ -cwd
#$ -l h_rt=1:00:00
#$ -l h_vmem=4G
#$ -o o_files
#$ -e e_files

# Run R script to get bed file from vcf

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

module load R

Rscript vcf_to_bed.R
