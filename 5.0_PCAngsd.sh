#!/bin/sh
# Grid Engine options
#$ -N pcangsd
#$ -cwd
#$ -l h_rt=2:00:00
#$ -l h_vmem=6G
#$ -pe sharedmem 2
#$ -o o_files
#$ -e e_files

# Jobscript to run PCAngsd on genotype likelihoods

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load python
module load python 

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/pcangsd
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/beagle
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/pcangsd

python $SOFTWARE_DIR/pcangsd.py \
	-beagle $TARGET_DIR/ORYX_GL_DS_NS.beagle.gz \
	-threads 2 \
	-o $OUTPUT_DIR/ORYX_GL_DS_NS_PCAngsd_covmat


