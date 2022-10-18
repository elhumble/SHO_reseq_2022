#!/bin/sh
#$ -N saf2theta
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=12G
#S -pe sharedmem 2
#$ -R y
#$ -t 1-29
#$ -e e_files
#$ -o o_files

# Get theta estimates at pop level

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/software/angsd-v0.935-53
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/sfs
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna

# Get list of bamfile lists in target directory

pop_file=`echo $1`

# Get file to be processed by *this* task
# Extract the Nth file in the list of files, $bam, where N == $SGE_TASK_ID

echo Processing files: ${pop_file} on $HOSTNAME

bams=`echo $pop_file | cut -f 2 -d '/'`

base=`echo $pop_file | cut -f 2 -d '/' | cut -f 1 -d '_'`

echo Also processing base: ${base}


# Calculate thetas for each site

$SOFTWARE_DIR/misc/realSFS saf2theta ${OUTPUT_DIR}/${base}_${SGE_TASK_ID}.saf.idx -sfs ${OUTPUT_DIR}/${base}_${SGE_TASK_ID}.sfs -outname ${OUTPUT_DIR}/${base}_${SGE_TASK_ID}

# Extract logscale per site thetas

$SOFTWARE_DIR/misc/thetaStat print ${OUTPUT_DIR}/${base}_${SGE_TASK_ID}.thetas.idx 2>/dev/null | head 

# Calculate statistics

$SOFTWARE_DIR/misc/thetaStat do_stat ${OUTPUT_DIR}/${base}_${SGE_TASK_ID}.thetas.idx

# Sliding window

# $SOFTWARE_DIR/misc/thetaStat do_stat ${OUTPUT_DIR}_${base}_${SGE_TASK_ID}.thetas.idx -win 50000 -step 10000 -outnames \
#	${OUTPUT_DIR}/${base}_${SGE_TASK_ID}.thetaswindow.gz
