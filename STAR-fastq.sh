#!/bin/bash

star=`which STAR`
fq_dir="/home/kcoyle/Audas-data/cutadapt_fastq"
star_dir="/home/kcoyle/Audas-data/STAR"
samples=()
for i in $(cat /home/kcoyle/Audas-data/cutadapt_fastq/files.txt); do
    samples+=($i)
done

for i in ${samples[@]};do
            echo "Running sample $i"
            mkdir $star_dir/${i}

            $star --runMode alignReads \
            --runThreadN 16 \
                --genomeDir /projects/reference/igenomes/Homo_sapiens/GSC/GRCh38/Sequence/StarIndexWithAnns-2.4.2a/sjdbOverhang99 \
            --genomeLoad NoSharedMemory \
            --sjdbGTFfile /projects/reference/igenomes/Homo_sapiens/GSC/GRCh38/Annotation/Genes/gencode.v23.gtf \
            --sjdbOverhang 99 \
                --readFilesIn $fq_dir/${i}.trimmed_1.fastq.gz $fq_dir/${i}.trimmed_2.fastq.gz \
            --readFilesCommand zcat \
            --outFileNamePrefix $star_dir/${i}/${i} \
            --outSAMtype BAM SortedByCoordinate \
                  --outSAMattrIHstart 0 \
                  --chimSegmentMin 20 \
		  --chimOutType WithinBAM SoftClip \
                  --quantMode TranscriptomeSAM GeneCounts \
                  --twopassMode Basic
done
