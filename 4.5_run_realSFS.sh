for i in $(cat file_lists/DS_NS_rmdup_bams.txt); do
	echo $i
	qsub scripts/4.5_realSFS.sh $i
done
