library(data.table)
library(dplyr)
library(tidyr)

# Manipulating polarised output files from other species alignments ready to reorder VCF file for SNPeff

anc_wild <- fread("/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/ancestral_alleles.out", header = F)

SNP_ID_wild <- filter(anc_wild, grepl(">", V1))

map <- fread("/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/4_vcftools/DS_NS/ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf.map")

SNPs_wild <- anc_wild %>%
  filter(!grepl(">", V1)) %>%
  mutate(ID = SNP_ID_wild$V1) %>%
  mutate(CHR = map$V2) %>%
  mutate(SNP = map$V4)

wild_Ns <- SNPs_wild %>%
  filter(V1 == "N")

SNPs_wild %>%
  filter(V1 != "N") %>%
  select(CHR, V1) %>%
  write.table("/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/ancestral_alleles.txt", quote = F,
	      col.names = F, row.names = F)

