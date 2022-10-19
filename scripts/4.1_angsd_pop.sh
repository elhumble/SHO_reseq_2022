#!/bin/sh
#$ -N angsd_pop
#$ -cwd
#$ -l h_rt=12:00:00
#$ -l h_vmem=8G
#S -pe sharedmem 4
#$ -R y
#$ -t 1-29
#$ -e e_files
#$ -o o_files

# Jobscript to get GLs using ANGSD per pop

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/angsd/
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/pop_beagle
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna

SCAFF_LIST=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/scaff_IDs

# Get chr to be processed by *this* task

SCAFF=`sed -n "$SGE_TASK_ID"p $SCAFF_LIST | awk '{print $1}'`

# Get list of bamfile lists in target directory

pop_file=`echo $1`

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

echo Processing files: ${pop_file} on $HOSTNAME

bams=`echo $pop_file | cut -f 2 -d '/'`

base=`echo $pop_file | cut -f 2 -d '/' | cut -f 1 -d '_'`

echo Also processing base: ${base}

# Find global estimate of SFS for each pop and species

echo Finding global estimate of SFS...

$SOFTWARE_DIR/angsd \
	-P 1 \
       	-b $pop_file \
        -ref $REFERENCE \
	-r $SCAFF \
        -anc $REFERENCE \
        -out $OUTPUT_DIR/${base}_${SGE_TASK_ID} \
        -uniqueOnly 1 \
        -remove_bads 1 \
        -only_proper_pairs 1 \
        -trim 0 \
        -C 50 \
        -baq 1 \
        -minMapQ 30 \
        -minQ 30 \
        -doCounts 1 \
        -GL 2 \
	-doGlf 2 \
	-doMajorMinor 4 \
	-doMaf 1 \
	-doGeno 2 \
	-doPost 1 \
	-SNP_pval 1e-6
