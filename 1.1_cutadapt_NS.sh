#!/bin/sh
# Grid Engine options
#$ -N cutadapt
#$ -cwd
#$ -l h_rt=4:00:00
#$ -l h_vmem=4G
#S -pe sharedmem 4
#$ -R y
#$ -e e_files
#$ -o o_files
#$ -t 1-180

# Jobscript to run cutadapt

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load cutadapt and set up vars

module add igmm/apps/cutadapt/1.16
module add python/3.4.3

OUTPUT_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/cutadapt
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/raw
SAMPLE_SHEET="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/file_lists/sample_path.txt"

# Get list of files

base=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $1}'`
r1_path=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $2}'`
r2_path=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $3}'`

r1_name=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $2}' | cut -f 2 -d '/'`
r2_name=`sed -n "$SGE_TASK_ID"p $SAMPLE_SHEET | awk '{print $3}' | cut -f 2 -d '/'`

echo Processing files: ${base} ${r1_path} ${r2_path} ${r1_name} ${r2_name}

# Cutadapt

cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC \
	-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT \
	-q 30 -m 35 -f fastq \
	-o $OUTPUT_DIR/cutadapt_${base}_${r1_name} \
	-p $OUTPUT_DIR/cutadapt_${base}_${r2_name} \
	$TARGET_DIR/$r1_path \
	$TARGET_DIR/$r2_path



