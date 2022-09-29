# Hands-on Session - microbial network analysis
calculate correlation matrix

FastSpar(github.com/scwatts/FastSpar) was used to calculate correlation matrix via command line.

mkdir bootstrap_counts bootstrap_correlation

step1: Correlation inference
```
fastspar --otu_table data1.txt --correlation median_correlation.tsv --covariance median_covariance.tsv > log1
```
step2: Calculation of exact p-values, first generate 1000 bootstrap counts
```
mkdir bootstrap_counts fastspar_bootstrap --otu_table data1.txt --number 1000 --prefix bootstrap_counts/ > log2
```
step3: infer correlations for each bootstrap count (running in parallel):
```
mkdir bootstrap_correlation parallel -j 12 fastspar --otu_table {} --correlation bootstrapcorrelation/cor{/} --covariance bootstrapcorrelation/cov{/} -i 50 ::: bootstrap_counts/* > log3
```
step4: From these correlations, the p-values are then calculated:
```
fastspar_pvalues --otu_table data1.txt --correlation median_correlation.tsv --prefix bootstrapcorrelation/cor --permutations 1000 --outfile pvalues.tsv > log4
```
output files are in data folder : median_correlation.tsv and pvalues.tsv , remove "#" from the files before opening in R

Step5: Take the correlation of Pseudomonas ASVs with ANPR and Mesorisubiums from correlation matri
