library(dplyr)
library(purrr)
library(tidyr)
library(data.table)

#~~ Create bed file of SNPs to extract from consensus fasta

map <- fread("/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/4_vcftools/DS_NS/ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf.map")

bed <- map %>%
	select(V1, V4) %>%
   	mutate(start = V4 - 1,
	              name = "SNP") %>%
        select(V1, start, V4, name)

write.table(bed, "/exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/6_load/DS_NS/polarise/wildebeest_topi_hartebeest/ORYX_geno_DS_NS_biallelic_chr_mdepth_miss_maf.bed",
	    quote = F, row.names = F, col.names = F, sep = "\t")

