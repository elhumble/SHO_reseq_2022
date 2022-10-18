#!/bin/sh
# Grid Engine options
#$ -N snpEff
#$ -cwd
#$ -l h_rt=8:00:00
#$ -l h_vmem=12G
#$ -R y
#$ -o o_files
#$ -e e_files

# Jobscript to build snpEff database

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 
module load igmm/apps/BEDOPS/2.4.26

# Specifiy some paths

SNPEFF_PATH=/exports/cmvm/eddie/eb/groups/ogden_grp/software/snpEff

VCF=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf_polarised.vcf
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/snpeff
CONFIG=/exports/cmvm/eddie/eb/groups/ogden_grp/software/snpEff/snpEff.config

# Build database -- see workflow

# Run snpEff

java -Xmx8g -jar $SNPEFF_PATH/snpEff.jar \
	-c $CONFIG \
	-csvStats stats.csv \
	-v GCF_014754425.2_SCBI_Odam_1.1_genomic \
	$VCF > $OUTPUT_DIR/ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf_polarised_annotated.vcf

