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

Q: Why do we have 3 files? What does R1, I1 and R2 in the files names mean? 
