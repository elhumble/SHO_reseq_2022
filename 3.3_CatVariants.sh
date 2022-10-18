#!/bin/sh
# Grid Engine options
#$ -N CatVariants
#$ -cwd
#$ -l h_rt=2:00:00
#$ -l h_vmem=12G
#$ -o o_files
#$ -e e_files

# Jobscript to Concatenate Variants

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/2_ggvcfs/DS_NS
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/3_catvars/DS_NS
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna
#CHR="HiC_scaffold_${SGE_TASK_ID}"

# Run process

java -Xmx8G -cp /exports/cmvm/eddie/eb/groups/ogden_grp/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar \
	org.broadinstitute.gatk.tools.CatVariants \
	-R $REFERENCE \
	-V $TARGET_DIR/HiC_scaffold_1.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_2.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_3.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_4.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_5.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_6.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_7.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_8.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_9.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_10.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_11.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_12.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_13.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_14.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_15.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_16.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_17.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_18.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_19.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_20.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_21.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_22.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_23.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_24.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_25.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_26.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_27.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_28.vcf.gz \
	-V $TARGET_DIR/HiC_scaffold_29.vcf.gz \
	-V $TARGET_DIR/unplaced.vcf.gz \
	-out $OUTPUT_DIR/ORYX_geno_DS_NS.vcf.gz \
	-assumeSorted










