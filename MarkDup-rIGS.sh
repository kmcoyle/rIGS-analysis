#!/bin/bash

picard="/home/kcoyle/anaconda3/share/picard-2.20.4-0/picard.jar"
star_dir="/home/kcoyle/Audas-data/rIGS/STAR/"
dup_dir="/home/kcoyle/Audas-data/rIGS/markdup"

while read i; do
            echo "Running sample $i"
            mkdir $dup_dir/${i}

            java -XX:ParallelGCThreads=10 -jar $picard MarkDuplicates \
                I=${star_dir}/${i}/${i}Aligned.sortedByCoord.out.bam \
                O=${dup_dir}/${i}MarkedDuplicates.bam \
		M=${dup_dir}/${i}MarkedDupMetrics.txt
done < /home/kcoyle/Audas-data/cutadapt_fastq/files.txt
