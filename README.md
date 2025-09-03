# kraken2-reports-host-decontamination
Kraken2 classification reports after Gallus gallus decontamination
# Kraken2 Classification Reports – Gallus gallus Decontamination

This repository contains Kraken2 classification reports (`report.txt`) for six metagenomic samples (P1–P6), generated after host DNA decontamination against the *Gallus gallus* reference genome using Bowtie2.

## Files

- `P1_report.txt`
- `P2_report.txt`
- `P3_report.txt`
- `P4_report.txt`
- `P5_report.txt`
- `P6_report.txt`

## Description

Raw metagenomic reads were sequenced using the Illumina NovaSeq 6000 platform (2×150 bp). Host DNA was removed by mapping reads against the *Gallus gallus* genome using Bowtie2 on Galaxy Europe. Unaligned reads were retained for taxonomic classification using Kraken2. Each report summarizes the taxonomic assignments for one sample and serves as input for downstream abundance estimation with Bracken.

## Citation

If you use these files, please cite the associated publication:

> [Insert article title here]  
> [Insert author list]  
> DOI: [Insert article DOI when available]

This dataset is archived via Zenodo:  
**DOI: [Insert Zenodo DOI once generated]**

## License

This dataset is released under the [Creative Commons Attribution 4.0 International License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).
