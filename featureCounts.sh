#!/bin/bash

featureCounts=`which featureCounts`
index="/projects/reference/igenomes/Homo_sapiens/GSC/GRCh38/Annotation/Genes/gencode.v23.gtf"
dir="/home/kcoyle/Audas-data/markdup"
out="/home/kcoyle/Audas-data/featureCounts"
while read i; do
    echo "Running sample $i"
    $featureCounts -a $index -O -T 32 --ignoreDup --splitOnly -p -t exon -g gene_id -s 2 -Q 10 \
        -o $out/${i}_counts.txt \
       $dir/${i}MarkedDuplicates.sorted.bam
done < /home/kcoyle/Audas-data/cutadapt_fastq/files.txt
