for i in $(ls file_lists/*POP.txt); do
	        echo $i
		        qsub scripts/4.1_angsd_pop.sh $i
		done
