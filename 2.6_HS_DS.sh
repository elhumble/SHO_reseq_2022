#!/bin/sh
# Grid Engine options
#$ -N HS_DS
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=8G
#S -pe sharedmem 6
#$ -o o_files
#$ -e e_files

# Jobscript to create sequence dictionary

# Initialise the Modules environment
. /etc/profile.d/modules.sh

module load R

# Run Rscript to determine downsampling proportions

Rscript bam_cov_DS.R

