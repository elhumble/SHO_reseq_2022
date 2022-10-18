#!/bin/sh
# Grid Engine options
#$ -N HapCaller
#$ -cwd
#$ -l h_rt=12:00:00
#$ -l h_vmem=12G
#$ -pe sharedmem 2
#$ -t 1-30
#$ -e e_files
#$ -o o_files

# Jobscript to run Haplotype Caller across samples and chromosomes

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java
#module add igmm/apps/GATK/3.8-0

SAMPLE=`echo $1`
echo Sample: $SAMPLE

REFERENCE="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna"

SCAFF_PATHS="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/scaff_ID_paths"
THIS_SCAFF_PATH=`sed -n "$SGE_TASK_ID"p $SCAFF_PATHS | awk '{print $1}'`

SCAFF_ID=$(echo "${THIS_SCAFF_PATH}" | cut -f 12 -d '/')

echo Full path -L param: $THIS_SCAFF_PATH
echo Scaff ID for file out: $SCAFF_ID


# Run process

java -Xmx8G -jar /exports/cmvm/eddie/eb/groups/ogden_grp/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar \
       	-T HaplotypeCaller \
	-R $REFERENCE \
	-I ${SAMPLE} \
	-o ${SAMPLE%_merged_rmdup.bam}_${SCAFF_ID%_ID.intervals}.g.vcf.gz \
	-L $THIS_SCAFF_PATH \
	-ERC GVCF \
	-nct 2


