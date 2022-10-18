#!/bin/sh
# Grid Engine options
#$ -N VEP
#$ -cwd
#$ -l h_rt=12:00:00
#$ -l h_vmem=2G
#$ -R y
#$ -o o_files
#$ -e e_files

# Jobscript to run VEP

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Load Dependencies and setup env variables #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Initialise the Modules environment
. /etc/profile.d/modules.sh

# Load java

module load roslin/vep/99.2
 
OUTPUT_DIR="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/vep"
VCF="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf_polarised.vcf"

GFF="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/annotation/GCF_014754425.2_SCBI_Odam_1.1_genomic.gff.gz"
REF="/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/reference/GCF_014754425.2_SCBI_Odam_1.1_genomic.fna"

# Run VEP on polarised vcf file

vep -i $VCF \
	--gff $GFF \
	--pick \
       	--fasta $REF \
      	--output_file $OUTPUT_DIR/ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf_polarised_annotated.txt
 

