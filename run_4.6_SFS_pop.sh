for i in $(ls file_lists/*DS_NS_POP.txt); do
	        echo $i
		        qsub 4.6_SFS_pop.sh $i
		done
