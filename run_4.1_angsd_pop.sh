for i in $(ls file_lists/*POP.txt); do
	        echo $i
		        qsub 4.1_angsd_pop.sh $i
		done
