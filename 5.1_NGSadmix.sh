#!/bin/sh
# Grid Engine options
#$ -N ngsadmix
#$ -cwd
#$ -l h_rt=24:00:00
#$ -l h_vmem=12G
#S -pe sharedmem 4
#$ -o o_files
#$ -e e_files
#$ -t 4-6
#$ -M emily.humble@ed.ac.uk
#$ -m beas

# Jobscript to NGSadmix on genotype likelihoods

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/angsd/misc/
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/beagle
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/ngsadmix

for i in 1 2 3 4 5 6 7 8 9 10
do
	$SOFTWARE_DIR/NGSadmix \
	-likes $TARGET_DIR/ORYX_GL_DS_NS.beagle.gz \
	-K ${SGE_TASK_ID} \
	-P 1 \
	-seed $i \
	-o $OUTPUT_DIR/ORYX_GL_DS_NS_NGSadmix_K${SGE_TASK_ID}_run${i}_out
done


