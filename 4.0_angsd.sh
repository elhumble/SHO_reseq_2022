#!/bin/sh
# Grid Engine options
#$ -N angsd_gl
#$ -cwd
#$ -l h_rt=16:00:00
#$ -l h_vmem=6G
#S -pe sharedmem 4
#$ -o o_files
#$ -e e_files
#$ -t 1-29

# Jobscript to get gls from bams with angsd

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

#SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/angsd/
SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/software/angsd-v0.935-53

BAM_LIST=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/DS_NS_rmdup_bams.txt
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/beagle
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna
SCAFF_LIST=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/scaff_IDs

SCAFF=`sed -n "$SGE_TASK_ID"p $SCAFF_LIST | awk '{print $1}'`

echo $SCAFF

# Run process

# Genotype likelihoods and SNP / allele frequencies

$SOFTWARE_DIR/angsd \
	-b $BAM_LIST \
	-ref $REFERENCE \
	-r $SCAFF \
	-out $OUTPUT_DIR/$SCAFF \
	-uniqueOnly 1 \
	-remove_bads 1 \
	-only_proper_pairs 1 \
	-trim 0 \
	-C 50 \
	-baq 1 \
	-minMapQ 30 \
	-minQ 30 \
       	-minInd 30 \
	-doCounts 1 \
	-GL 2 \
	-doGlf 2 \
	-doMajorMinor 4 \
	-doMaf 1 \
	-SNP_pval 1e-6 \
	-doGeno 2 \
	-doPost 1 \
	-setMinDepth 245 \
	-setMaxDepth 1000

# -doPlink 2
# -doMaf 1
# -setMinDepth 325
# -setMaxDepth 1950
# -geno_minDepth 5
