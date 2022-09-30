# Hands-on Session - amplicon sequencing data prossesing using "mothur" pipline
Make an environment via conda and Install “mothur” and “jupyter lab” 
```
conda create -n myenv -c conda-forge -c bioconda  jupyterlab  r-irkernel mothur
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
Do not run this command! We already did it for you and the results are already in the folder. It’s the ‘File_FastqInfo...’ files.
This next step will pair single reads into paired-end reads and creates contigs.
Let’s do this with the “make.contigs” command. (2-3min)
```
make.contigs(file=FastqFiles.txt, processors=12)
```
This command will also produce several files that you will need down the road: stability.trim.contigs.fasta and stability.contigs.count_table. These contain the sequence data and group identity for each sequence. The stability.contigs.report file will tell you something about the contig assembly for each read. Let’s see what these sequences look like using the summary.seqs command:

 FastqFiles.scrap.contigs.fasta
 FastqFiles.trim.contigs.fasta
 FastqFiles.contigs.count_table
 FastqFiles.contigs_report
 mothur.1664548140.logfile

```
 File_FastqInfo.B5.*
```
14s
```
screen.seqs(fasta=FastqFiles.trim.contigs.fasta, count=FastqFiles.contigs.count_table,contigsreport= FastqFiles.contigs_report, minoverlap=5, maxambig=0, maxhomop=10, minlength=100, maxlength=600, processors=12)
```
Output File Names:
FastqFiles.good.[extension]
FastqFiles.trim.contigs.good.fasta
FastqFiles.trim.contigs.bad.accnos
FastqFiles.contigs.good.count_table
```
####rename.seqs(fasta=FastqFiles.trim.contigs.good.fasta, group=Undetermined_S0_L001_R1_001.contigs.good.groups)
```
```
unique.seqs(fasta=FastqFiles.trim.contigs.good.fasta, count=FastqFiles.contigs.good.count_table)
```
Output File Names: 
FastqFiles.trim.contigs.good.unique.fasta
FastqFiles.trim.contigs.good.count_table

```
chimera.vsearch(fasta=FastqFiles.trim.contigs.good.unique.fasta, count=FastqFiles.trim.contigs.good.count_table, processors=12)
```
Output File Names:
FastqFiles.trim.contigs.good.unique.denovo.vsearch.chimeras
FastqFiles.trim.contigs.good.unique.denovo.vsearch.accnos
FastqFiles.trim.contigs.good.denovo.vsearch.count_table
FastqFiles.trim.contigs.good.unique.denovo.vsearch.fasta

```
remove.seqs(accnos=FastqFiles.trim.contigs.good.unique.denovo.vsearch.accnos, fasta=FastqFiles.trim.contigs.good.unique.fasta, count=FastqFiles.trim.contigs.good.count_table)
```
Output File Names:
FastqFiles.trim.contigs.good.unique.pick.fasta
FastqFiles.trim.contigs.good.pick.count_table


15-20 min. stop and transfer from cheat files
```
classify.seqs(fasta=FastqFiles.trim.contigs.good.unique.pick.fasta, template=SilvaDB.fasta, taxonomy=SilvaDB.tax, processors=12) 
```
Output File Names: 
FastqFiles.trim.contigs.good.unique.pick.SilvaDB.wang.taxonomy
FastqFiles.trim.contigs.good.unique.pick.SilvaDB.wang.tax.summary
FastqFiles.trim.contigs.good.unique.pick.SilvaDB.wang.flip.accnos

```
cluster(fasta=FastqFiles.trim.contigs.good.unique.pick.fasta, count=FastqFiles.trim.contigs.good.pick.count_table, method=dgc, cutoff=0.03)
```

Output File Names: 
FastqFiles.trim.contigs.good.unique.pick.dgc.list








