for i in $(ls file_lists/*DS_NS_POP.txt); do
	        echo $i
		        qsub 4.7_doThetas_pop.sh $i
		done
