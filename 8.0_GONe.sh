#!/bin/sh
# Grid Engine options
#$ -N Gone
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=2G
#$ -pe sharedmem 6
#$ -o o_files
#$ -e e_files

# Jobscript to create sequence dictionary

# Initialise the Modules environment
. /etc/profile.d/modules.sh

module load R
module load roslin/plink/1.90p

# Specifiy some paths

POP=EEP

TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/4_IBD_IBC/DS_NS
PLINK_FILE=ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf

OUT_DIR=data/out/8_gone/DS_NS/
PLINK_FILE_GONE=ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf_${POP}_sub


plink --file $TARGET_DIR/$PLINK_FILE \
	--keep file_lists/${POP}.txt \
	--extract $TARGET_DIR/temp_SNP_sub \
	--mac 1 \
	--out $OUT_DIR/$POP/$PLINK_FILE_GONE \
	--recode \
	--not-chr NW_024070207.1 \
	--allow-extra-chr --nonfounders --debug

# Recode map file CHR column for GONe

Rscript recode_map_gone.R $OUT_DIR/${POP}/${PLINK_FILE_GONE}.map

# Run Gone
echo $OUT_DIR/$POP/$PLINK_FILE_GONE

bash script_GONE.sh $OUT_DIR/$POP/$PLINK_FILE_GONE

mv outfileHWD outfileLD_d2_sample outfileLD_Ne_estimates seedfile timefile $OUT_DIR/$POP
mv TEMPORARY_FILES $OUT_DIR/$POP

