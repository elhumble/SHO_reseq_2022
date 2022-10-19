#!/bin/sh
#$ -N angsdHet
#$ -cwd
#$ -l h_rt=8:00:00
#$ -l h_vmem=8G
#S -pe sharedmem 4
#$ -t 1-29
#$ -o o_files
#$ -e e_files

# Script to calculate single-sample SFS using ANGSD for list of samples to calculate genome-wide heterozygosity

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/angsd/
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/ind_het_ml
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna

SCAFF_LIST=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/scaff_IDs

echo Processing ${file} and ${base}

SAMPLE=`echo $1`
base=`echo $1 | awk '{print $1}' | cut -f 14 -d '/' | cut -f 1 -d '.' | cut -f 1 -d '_'`

SCAFF=`sed -n "$SGE_TASK_ID"p $SCAFF_LIST | awk '{print $1}'`
echo $SCAFF

# Run process

$SOFTWARE_DIR/angsd \
       -P 1 \
       -uniqueOnly 1 \
       -remove_bads 1 \
       -only_proper_pairs 1 \
       -baq 1 \
       -minMapQ 20 \
       -minQ 20 \
       -doCounts 1 \
       -setMinDepth 5 \
       -setMaxDepth 21 \
       -ref $REFERENCE \
       -r $SCAFF \
       -i $SAMPLE \
       -doSaf 1 \
       -anc $REFERENCE \
       -GL 1 \
       -fold 1 \
       -out $OUTPUT_DIR/${base}_${SGE_TASK_ID}


# -rf $AUTO for all autosomes
# -downSample 0.25
