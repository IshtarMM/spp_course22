# Hands-on Session - amplicon sequencing data prossesing using "mothur" pipline
Make an environment via conda and Install “mothur” and “jupyter lab” 
```
conda create -n myenv -c conda-forge jupyterlab  r-irkernel -c bioconda mothur
```
activate the environmrnt
```
conda activate myenv
```
change working directory
```
cd /mnt/volume/seqdata/
```
First, take a look at the output files from the Miseq machine:

- Undetermined_S0_L001_I1_001.fastq 
- Undetermined_S0_L001_R1_001.fastq
- Undetermined_S0_L001_R2_001.fastq

**Q: Why do we have 3 files? What does R1, I1 and R2 in the files names mean?**
Normally you get the sequences from all samples together and you have to divide them this is called de-multiplexing. The first step is then to divide all the data into the different samples using the ‘fastq.info’ command.

Q: For this command we have to provide the oligos file why?
Q: What does bdiffs=2 mean?
Q: What is in the ‘File_FastqInfo.txt’ file? What information is it giving mothur?
```
fastq.info(file=File_FastqInfo.txt, oligos=barcodes_practical.txt, bdiffs=2, fasta=F, qfile=F)
```
This next step will pair single reads into paired-end reads and creates contigs.
Let’s do this with the “make.contigs” command.
```
make.contigs(file=Undetermined_S0_L001_R1_001.files, processors=2)
```










