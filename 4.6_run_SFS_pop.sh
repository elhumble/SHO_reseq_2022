for i in $(ls file_lists/*DS_NS_POP.txt); do
	        echo $i
		        qsub scripts/4.6_SFS_pop.sh $i
		done
