# Hands-on Session - amplicon sequencing data prossesing using "mothur" pipline
## Step1: Install required programs
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
----

**File Description**

#### First, take a look at the output files from the Miseq machine:

- Forward.fastq :The sequencing reads from the forward strand
- Reverse.fastq :The sequencing reads from the reverse strand
- Index.fastq :The barcode reads at each coordination

## Step2: de-multiplexing:
Normally you get the sequences from all samples together and you have to divide them this is called de-multiplexing. The first step is then to divide all 
```
fastq.info(file=File_FastqInfo.txt, oligos=barcodes_practical.txt, bdiffs=2, fasta=F, qfile=F)
```
##### Do not run this command!
We already did it for you and the results are already in the folder. It’s the ‘File_FastqInfo...’ files.

## Step3: creates contigs:
This next step will pair single reads into paired-end reads and creates contigs.
Let’s do this with the “make.contigs” command. (2-3min)
```
make.contigs(file=FastqFiles.txt, processors=12)
```
This command will also produce several files that you will need down the road: stability.trim.contigs.fasta and stability.contigs.count_table. These contain the sequence data and group identity for each sequence. The stability.contigs.report file will tell you something about the contig assembly for each read. Let’s see what these sequences look like using the summary.seqs command:

 - FastqFiles.scrap.contigs.fasta
 - FastqFiles.trim.contigs.fasta
 - FastqFiles.contigs.count_table
 - FastqFiles.contigs_report
 - mothur.*.logfile

## Step4: screen sequences:
The screen.seqs command enables you to keep sequences that fulfill certain user defined criteria

```
screen.seqs(fasta=FastqFiles.trim.contigs.fasta, count=FastqFiles.contigs.count_table,contigsreport= FastqFiles.contigs_report, minoverlap=5, maxambig=0, maxhomop=10, minlength=100, maxlength=600, processors=12)
```
Output File Names:
- FastqFiles.good.[extension]
- FastqFiles.trim.contigs.good.fasta
- FastqFiles.trim.contigs.bad.accnos
- FastqFiles.contigs.good.count_table


## Step5:unique sequences:
We anticipate that many of our sequences are duplicates of each other. Because it’s computationally wasteful to align the same thing a bazillion times, we’ll unique our sequences using the unique.seqs command

```
unique.seqs(fasta=FastqFiles.trim.contigs.good.fasta, count=FastqFiles.contigs.good.count_table)
```
Output File Names: 
- FastqFiles.trim.contigs.good.unique.fasta
- FastqFiles.trim.contigs.good.count_table

## Step6:chimera detection:
The chimera.vsearch command reads a fasta and count file or fasta file and reference file and outputs potentially chimeric sequences. The vsearch program is donated to the public domain, https://github.com/torognes/vsearch.

```
chimera.vsearch(fasta=FastqFiles.trim.contigs.good.unique.fasta, count=FastqFiles.trim.contigs.good.count_table, processors=12)
```
Output File Names:
- FastqFiles.trim.contigs.good.unique.denovo.vsearch.chimeras
- FastqFiles.trim.contigs.good.unique.denovo.vsearch.accnos
- FastqFiles.trim.contigs.good.denovo.vsearch.count_table
- FastqFiles.trim.contigs.good.unique.denovo.vsearch.fasta

## Step7:remove chimera:

Let’s now remove all the identified chimeric sequences from our data

```
remove.seqs(accnos=FastqFiles.trim.contigs.good.unique.denovo.vsearch.accnos, fasta=FastqFiles.trim.contigs.good.unique.fasta, count=FastqFiles.trim.contigs.good.count_table)
```
Output File Names:
- FastqFiles.trim.contigs.good.unique.pick.fasta
- FastqFiles.trim.contigs.good.pick.count_table


## Step8:classify our sequences:
Now let’s use the 16S data base to classify our sequences using the “classify.seqs” command.(15-20 min)
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

```
split.abund(fasta=FastqFiles.trim.contigs.good.unique.pick.fasta, count=FastqFiles.trim.contigs.good.pick.count_table, list=FastqFiles.trim.contigs.good.unique.pick.dgc.list, cutoff=50)
```
Output File Names: 
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03_OTUS.rare.accnos
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03_OTUS.abund.accnos
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.rare.list
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.list
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.rare.accnos
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.accnos
FastqFiles.trim.contigs.good.pick.0.03.rare.count_table
FastqFiles.trim.contigs.good.unique.pick.0.03.rare.fasta
FastqFiles.trim.contigs.good.pick.0.03.abund.count_table
FastqFiles.trim.contigs.good.unique.pick.0.03.abund.fasta

```
classify.otu(taxonomy=FastqFiles.trim.contigs.good.unique.pick.SilvaDB.wang.taxonomy, list=FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.list, count=FastqFiles.trim.contigs.good.pick.0.03.abund.count_table)
```
Output File Names: 
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.0.03.cons.taxonomy
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.0.03.cons.tax.summary
```
make.shared(list=FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.list, count=FastqFiles.trim.contigs.good.pick.0.03.abund.count_table)
```
Output File Names:
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.shared

```
get.oturep(fasta=FastqFiles.trim.contigs.good.unique.pick.0.03.abund.fasta, list=FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.list, count=FastqFiles.trim.contigs.good.pick.0.03.abund.count_table, method=abundance)
```
Output File Names: 
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.0.03.rep.count_table
FastqFiles.trim.contigs.good.unique.pick.dgc.0.03.abund.0.03.rep.fasta

ASVs🔗

OTUs generally represent sequences that are not more than 3% different from each other. In contrast, ASVs (aka ESVs) strive to differentiate sequences into separate OTUs if they are different from each other. There are challenges with this approach including the possibility of separating operons from the same genome into separate ASVs and that an ASV is typically really a cluster of sequences that are one or two bases apart from each other. Regardless, some people want to give this a go. The method built into mothur for identifying ASVs is pre.cluster. We did this above and then removed chimeras and contaminant sequences. We can convert the fasta and count_table files we used to form OTUs to a shared file using the make.shared command.
```
 make.shared(count=FastqFiles.trim.contigs.good.pick.count_table)
```
ASV

Output File Names:
FastqFiles.trim.contigs.good.pick.asv.list
FastqFiles.trim.contigs.good.pick.asv.shared
```
classify.otu(taxonomy=FastqFiles.trim.contigs.good.unique.pick.SilvaDB.wang.taxonomy, list=FastqFiles.trim.contigs.good.pick.asv.list, count=FastqFiles.trim.contigs.good.pick.count_table)
```
#command line mode
#dada2?




