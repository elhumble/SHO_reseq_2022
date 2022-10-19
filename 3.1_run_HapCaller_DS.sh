for i in $(ls /exports/cmvm/eddie/eb/groups/ogden_grp/emily/SHO_reseq_2022/data/out/0.1_bwa/DS/*downsample.bam); do
	echo $i
	qsub scripts/3.1_HapCaller.sh $i
done
