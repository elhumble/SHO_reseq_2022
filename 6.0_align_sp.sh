#!/bin/sh
# Grid Engine options
#$ -N bwa
#$ -cwd
#$ -M emily.humble@ed.ac.uk
#$ -l h_rt=48:00:00
#$ -l h_vmem=2G
#$ -t 1
#$ -pe sharedmem 6
#$ -R y
#$ -o o_files
#$ -e e_files

# Jobscript to align reads to reference

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load blast
#module load roslin/bwa/2.1.0
module add roslin/bwa/0.7.17
module load roslin/samtools/1.9 

TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/raw/other_species
OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/bam
SAMPLE_SHEET="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/sample_path_other_sp.txt"
REFERENCE="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna"

# Get list of files

base=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $1}'`
r1=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $2}'`
r2=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $3}'`


# Process and filter unmapped reads with samtools

echo Processing sample: ${base} ${r1} ${r2} on $HOSTNAME

bwa mem -t 6 $REFERENCE $TARGET_DIR/$r1 $TARGET_DIR/$r2 | samtools view -q 20 -bF 4 - > $OUTPUT_DIR/${base}_mapped.bam
