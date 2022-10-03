##calculate correlation matrix using FastSpar program

FastSpar(github.com/scwatts/FastSpar) was used to calculate correlation matrix

## Install FastSpar:
```
conda create --name fastspar  -c bioconda -c conda-forge fastspar
```
## activate environment

```
conda activate fastspar
```

## step1: Correlation inference
```
mkdir bootstrap_counts bootstrap_correlation
```
```
fastspar --otu_table data_net.txt --correlation median_correlation.tsv --covariance median_covariance.tsv > log1
```
## step2: Calculation of exact p-values, first generate 100 bootstrap counts
```
fastspar_bootstrap --otu_table data_net.txt --number 100 --prefix bootstrap_counts/ > log2
```
## step3: infer correlations for each bootstrap count (running in parallel):
```
parallel -j 4 fastspar --otu_table {} --correlation bootstrapcorrelation/cor{/} --covariance bootstrapcorrelation/cov{/} -i 50 ::: bootstrap_counts/* > log3
```
## step4: From these correlations, the p-values are then calculated:
```
fastspar_pvalues --otu_table data_net.txt --correlation median_correlation.tsv --prefix bootstrapcorrelation/cor --permutations 100 --outfile pvalues.tsv > log4
```
