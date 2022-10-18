#!/bin/sh
# Grid Engine options
#$ -N ngsld
#$ -cwd
#S -l h_rt=8:00:00
#$ -l h_rt=2:00:00
#$ -l h_vmem=2G
#S -pe sharedmem 2
#$ -o o_files
#$ -e e_files
#$ -t 1-29

# Jobscript to run LD analysis using ngsld on subsampled beagle file

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java
module add java 

SOFTWARE_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/software/ngsTools/ngsLD
TARGET_DIR=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/5_angsd/DS_NS/beagle
REFERENCE=/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna

# Get list of beagle files in target dir 
beagle=$(ls -1 ${TARGET_DIR}/*.1.beagle.gz)

# Get file to be processed by task
this_beagle=$(echo "${beagle}" | sed -n ${SGE_TASK_ID}p)

# Prepare a geno file by subsampling one SNP in every 50 SNPs in the beagle file

zcat $this_beagle | awk 'NR % 50 == 0' | cut -f 4- | gzip  > ${this_beagle%.beagle.gz}_subsampled.beagle.gz


# Get list of maf files
mafs=$(ls -1 ${TARGET_DIR}/*mafs.gz)
this_maf=$(echo "${mafs}" | sed -n ${SGE_TASK_ID}p)

# Make subsampled pos file

zcat $this_maf | cut -f 1,2 | awk 'NR % 50 == 0' | sed 's/:/_/g'| gzip > ${this_maf%.mafs.gz}_subsampled.pos.gz

# Get list of pos files

#pos=$(ls -1 ${TARGET_DIR}/*_subsampled.pos.gz)
#this_pos=$(echo "${pos}" | sed -n ${SGE_TASK_ID}p)

this_pos=$(echo "${this_maf%.mafs.gz}_subsampled.pos.gz")

# nsites

nsites=$(zcat $this_pos | wc -l)

echo $nsites
echo Processing $this_beagle and $this_pos

# sub beagle

#sub_beagle=$(ls -1 ${TARGET_DIR}/*_subsampled.beagle.gz)
#this_sub_beagle=$(echo "${sub_beagle}" | sed -n ${SGE_TASK_ID}p)

this_sub_beagle=$(echo "${this_beagle%.beagle.gz}_subsampled.beagle.gz")


echo Processing $this_sub_beagle

# Run ngsLD

$SOFTWARE_DIR/ngsLD \
	--geno $this_sub_beagle \
	--pos $this_pos \
	--probs \
	--n_ind 49 \
	--n_sites $nsites \
	--max_kb_dist 1000 \
	--n_threads 1 \
	--out ${this_beagle%.beagle.gz}.ld




