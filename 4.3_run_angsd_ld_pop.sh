pops="EAD EEP USA Hilwa"

for i in $pops; do
	        echo $i
		        qsub scripts/4.3_angsd_ld_pop.sh $i
		done
