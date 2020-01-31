#!bin/bash

###Analyze quality of raw reads
##Run fastqc for every fq.gz file
fastqc -o ../fastqcoutput ../Reaper/*.fq.gz

###Cut the adapters in 3' end using Reaper
for i in {1..2}; do
printf "\n"
echo "MODEK_EV_r${i}_100k"
MODEK="MODEK_EV_r${i}_100k.fq.gz"
reaper -geom no-bc -3pa TGGAATTCTCGGGTGCCAAGG -i ../Reaper/$MODEK -basename ../Reapoutput/MODEK_100k_r$i -format-clean '>%I%n%C%n'
done

for i in {1..2}; do
printf "\n"
echo "Pure_EV_r${i}_100k"
Pure="Pure_EV_r${i}_100k.fq.gz"
reaper -geom no-bc -3pa TGGAATTCTCGGGTGCCAAGG -i ../Reaper/$Pure -basename ../Reapoutput/Pure_100k_r$i -format-clean '>%I%n%C%n'
done

for i in {1..3}; do
printf "\n"
echo "MODEK_ctrl_r${i}_100k"
Ctrl="MODEK_ctrl_r${i}_100k.fq.gz"
reaper -geom no-bc -3pa TGGAATTCTCGGGTGCCAAGG -i ../Reaper/$Ctrl -basename ../Reapoutput/Ctrl_100k_r$i -format-clean '>%I%n%C%n'
done

###Move clean files into data directory
mv ../Reapoutput/*lane.clean.gz ../Reaper

###Rename files to a fasta format
for file in ../Reaper/*.clean.gz; do
mv $file ${file//clean/fa}
done