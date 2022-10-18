**Conservation management strategy impacts inbreeding and mutation load in scimitar-horned oryx**

**Summary**
-------------

This repository contains the scripts used for aligning reads and calling SNPs for resequenced individuals, running ANGSD, calling ROH, polarising alleles, annotating variants and running GONe.

For subsequent analyses described in the paper, please see github repository [SHO_roh_load_2022](https://github.com/elhumble/SHO_roh_load_2022).

**Code structure**
-------------

*Read alignment*  
`1.1_cutadapt_NS.sh`  
`1.2_IndexRef.sh`  
`2.0_AlignReads_HS.sh`  
`2.0_AlignReads_NS.sh`  
`2.1_SortSam.sh`  
`2.2_ReadGroups_HS.sh`  
`2.2_ReadGroups_NS.sh`  
`2.3_MergeSam_NS.sh`  
`2.4_MarkDups_HS.sh`  
`2.4_MarkDups_NS.sh`  
`2.5_BamCov.sh`  
`2.6_HS_DS.sh`  
`2.7_DownsampleBams.sh`  
`2.8_IndexBams.sh`  

*SNP calling*   
`3.0_SeqDict.sh`  
`3.1_HapCaller.sh`  
`3.2_GGVCFs_DS_NS.sh`  
`3.3_CatVariants.sh`  

*ANGSD analysis*    
`4.0_angsd.sh`  
`4.1_angsd_pop.sh`  
`4.2_angsd_ld.sh`  
`4.3_angsd_ld_pop.sh`  
`4.4_angsdHet.sh`  
`4.5_realSFS.sh`  
`4.6_SFS_pop.sh`  
`4.7_doThetas_pop.sh`  
`5.0_PCAngsd.sh`  
`5.1_NGSadmix.sh`  

*Polarisation and SNP annotation*  
`6.0_align_sp.sh`  
`6.1_SortSam.sh`  
`6.2_MergeSam.sh`  
`6.3_doFasta.sh`  
`6.4_vcf_to_bed.sh`  
`6.5_format_ancestral_alleles.sh`  
`7.0_SNPeff.sh`  
`7.1_VEP.sh`  

*Ne analysis*   
`8.0_GONe.sh`  

**Data**
-------------
Sequencing reads required to run the pipeline are available at the European Nucleotide Archive (https://www.ebi.ac.uk/ena/browser) under study accession [PRJEB37295](https://www.ebi.ac.uk/ena/browser/view/PRJEB37295?show=related-records).

Genome assembly and RefSeq annotation GCF_014754425.2 are available [here](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/754/425/GCF_014754425.2_SCBI_Odam_1.1/).
