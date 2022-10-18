#!/bin/sh
# Grid Engine options
#$ -N GenoGVCFs_DS
#$ -cwd
#$ -l h_rt=16:00:00
#$ -l h_vmem=12G
#S -pe sharedmem 2
#$ -t 1-30
#$ -e e_files
#$ -o o_files

# Jobscript to run Genotype GVCFs for each chromosome separately

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/1_hapcaller
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/2_ggvcfs/DS_NS
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna
SCRATCH=/exports/eddie/scratch/ehumble

SCAFF_PATHS="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/scaff_ID_paths"
THIS_SCAFF_PATH=`sed -n "$SGE_TASK_ID"p $SCAFF_PATHS | awk '{print $1}'`

SCAFF_ID=$(echo "${THIS_SCAFF_PATH}" | cut -f 12 -d '/' | cut -f 1 -d '.' | sed 's/_ID//')


#CHR="HiC_scaffold_${SGE_TASK_ID}"

# List files for each SGE TASK ID / CHR (20)
file_DS=$(ls $TARGET_DIR/DS/*_${SCAFF_ID}.g.vcf.gz)

# (45)
file_NS=$(ls $TARGET_DIR/NS/*_${SCAFF_ID}.g.vcf.gz)

# Combine variables
file_DS_NS=$(printf '%s\n' "$file_DS" "$file_NS")

# Set up input for command
vcflist=$(for f in $file_DS_NS; do echo -n "-V $f " ; done)

echo $vcflist

# Run process

java -Xmx8G -jar /exports/cmvm/eddie/eb/groups/ogden_grp/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar \
	-T GenotypeGVCFs \
	-nt 1 \
	-R $REFERENCE \
	-L $THIS_SCAFF_PATH \
	$vcflist \
	-o $OUTPUT_DIR/${SCAFF_ID}.vcf.gz
