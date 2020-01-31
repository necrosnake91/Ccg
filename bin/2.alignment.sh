#!bin/bash

###Align reads using bowtie
##First generate the index
bowtie-build ../Bowtie/Heligmosomoides_bakeri.fa.gz ../Bowtie/hbak

##Align the clean reads against the reference and store it as SAM format
#Reads from Pure EV
for i in {1..2}; do
printf "\n"
echo="Pure_100k_r$i"
bowtie -S -v 1 -k 1 -f ../Bowtie/hbak ../Reaper/Pure_100k_r${i}.lane.fa.gz ../Reaper/Pure_EV_r${i}_aligned.sam
done

#Reads from Ctrl 
for i in {1..3}; do
printf "\n"
echo="Ctrl_100k_r$i"
bowtie -S -v 1 -k 1 -f ../Bowtie/hbak ../Reaper/Ctrl_100k_r${i}.lane.fa.gz ../Reaper/Ctrl_r${i}_aligned.sam
done 

##Reads from experiment
for i in {1..2}; do
printf "\n"
echo="MODEK_100k_r$i"
bowtie -S -v 1 -k 1 -f ../Bowtie/hbak ../Reaper/MODEK_100k_r${i}.lane.fa.gz ../Reaper/MODEK_r${i}_aligned.sam
done

###Convert SAM to BAM
for file in ../Reaper/*.sam; do
samtools view -b $file > $file.bam
done