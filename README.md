# Klebsiella pneumoniae Transcriptome Analysis

## O-antigen deficiency, metabolic adaptation, and meropenem response

This repository contains a bacterial RNA-seq analysis of *Klebsiella pneumoniae* investigating how loss of O-antigen affects transcriptional responses to meropenem.

The analysis focuses on identifying strain-dependent treatment responses, interaction effects between genotype and meropenem exposure, and candidate pathways that may contribute to altered bacterial survival under antibiotic treatment.

---

## Project Overview

### Biological question

How does O-antigen deficiency alter the transcriptional response of *Klebsiella pneumoniae* to meropenem?

The analysis compares the parental strain **NK01067** with an **O-antigen-deficient ΔwbbM mutant** under control and meropenem-treated conditions.

The central statistical comparison is the **genotype × treatment interaction**, which identifies genes whose response to meropenem differs between the two strains.

### Study

* **SRA study:** SRP618458
* **Organism:** *Klebsiella pneumoniae*
* **Experiment:** RNA sequencing
* **Platform:** Illumina HiSeq 2500
* **Library:** Paired-end RNA-seq
* **Conditions:** Control and meropenem
* **Strains:** NK01067 and ΔwbbM
* **Biological replicates:** 3 per strain/treatment combination

### Experimental design

| Strain  | Treatment | Replicates |
| ------- | --------- | ---------: |
| NK01067 | Control   |          3 |
| NK01067 | Meropenem |          3 |
| ΔwbbM   | Control   |          3 |
| ΔwbbM   | Meropenem |          3 |

The study therefore contains four experimental groups and 12 biological samples.

---

# Analysis Strategy

The analysis was designed to move from raw sequencing data toward biological interpretation in several stages.

```text
Raw RNA-seq reads
        │
        ▼
Quality control
        │
        ▼
Read processing / alignment
        │
        ▼
Gene-level quantification
        │
        ▼
Count matrix
        │
        ▼
DESeq2 differential expression
        │
        ├── NK01067: meropenem vs control
        │
        ├── ΔwbbM: meropenem vs control
        │
        └── Genotype × treatment interaction
        │
        ▼
Candidate-gene classification
        │
        ▼
Mechanistic interpretation
        │
        ├── Cobalamin-associated genes
        ├── SULP-region analysis
        ├── Treatment-response genes
        └── High-confidence mechanistic candidates
        │
        ▼
Figures and final candidate lists
```

---

# Quality Control

Raw sequencing files were evaluated using **FastQC**.

Quality-control analysis was performed before downstream transcriptomic analysis to identify sequencing-quality issues such as:

* Per-base sequence quality
* Adapter contamination
* GC-content abnormalities
* Sequence duplication
* Overrepresented sequences
* Per-base sequence-content bias
* Per-tile quality variation

The FastQC results were reviewed before proceeding with downstream analysis.

---

# Reference Genome and Annotation

The analysis uses the **NK01067 reference genome**.

Reference files are stored under:

```text
reference/
├── annotation/
│   ├── NK01067.gff
│   └── NK01067.gff.gz
│
└── genome/
    ├── NK01067.fa
    ├── NK01067.fa.gz
    ├── NK01067.fa.fai
    ├── NK01067.fa.amb
    ├── NK01067.fa.ann
    ├── NK01067.fa.bwt
    ├── NK01067.fa.pac
    └── NK01067.fa.sa
```

The genome index files support read alignment and downstream quantification.

---

# Differential Expression Analysis

Differential expression was analyzed using **DESeq2**.

The experimental design separates the effects of:

1. Strain/genotype
2. Meropenem treatment
3. The interaction between strain and treatment

The interaction term is particularly important because it asks:

> Does the transcriptional response to meropenem differ between NK01067 and ΔwbbM?

A significant interaction therefore identifies genes for which the treatment response is dependent on the bacterial strain.

---

## Treatment-specific comparisons

Separate treatment contrasts were evaluated for:

### NK01067

```text
Meropenem vs Control
```

### ΔwbbM

```text
Meropenem vs Control
```

These comparisons help establish the transcriptional response to meropenem within each strain.

The interaction analysis then determines which responses differ between the two strains.

---

# Interaction Analysis

The primary interaction analysis uses a model containing the strain, treatment, and strain × treatment interaction.

Conceptually:

```text
Expression ~ Strain + Treatment + Strain:Treatment
```

The interaction term identifies genes showing a different meropenem response in ΔwbbM compared with NK01067.

This distinction is important because a gene can be strongly affected by meropenem in both strains without necessarily showing a strain-specific response.

---

# Candidate-Gene Analysis

Several filtering and classification steps were used to identify genes of potential mechanistic interest.

The repository contains intermediate and refined candidate lists, including:

```text
results/counts/
├── significant_interaction_genes.tsv
├── significant_interaction_positive.tsv
├── significant_interaction_negative.tsv
├── interaction_gene_summary.tsv
├── top_interaction_candidates.tsv
├── high_confidence_candidates.tsv
├── high_confidence_candidates_final.tsv
├── mechanistic_shortlist.tsv
├── final_mechanistic_shortlist.tsv
├── opposite_direction_candidates.tsv
├── opposite_direction_classified.tsv
├── opposite_direction_curated.tsv
└── opposite_direction_strong_candidates.tsv
```

The progressively refined candidate lists were used to distinguish statistically significant interaction genes from candidates with stronger mechanistic relevance.

---

# Cobalamin-Associated Analysis

A focused analysis was performed on a cluster of genes associated with **cobalamin/vitamin B12-related biology**.

The analysis examined:

* Treatment-dependent expression changes
* Strain-dependent responses
* Interaction effects
* Cluster-level behavior
* Coverage across the relevant genomic region

Key outputs include:

```text
results/figures/cobalamin_cluster_coverage_final.png
results/figures/cobalamin_cluster_interaction_log2FC.png
results/figures/cobalamin_cluster_strain_response.png
```

These figures provide complementary views of the transcriptional behavior of the cobalamin-associated region.

The analysis does not assume that differential expression alone establishes a causal mechanism. Instead, these genes are treated as candidates for further biological investigation.

---

# SULP-Region Analysis

A separate analysis examined a genomic region containing a **SULP-family inorganic anion transporter candidate** and surrounding genes.

The analysis included:

* Identification of candidate genes
* Read-depth/coverage analysis
* Comparison of coverage across selected samples
* Visualization of the region

The main figure is:

```text
results/figures/sulp_region_coverage.png
```

Candidate information is stored in:

```text
results/counts/sulp_region_candidates.tsv
```

Coverage calculations are available locally under:

```text
results/coverage/sulp_region/
```

These analyses were used to investigate whether transcriptional changes in the region were supported by read coverage patterns.

---

# Main Figures

The repository contains several analysis figures.

### Final mechanistic heatmap

```text
results/figures/final_mechanistic_heatmap.png
```

This summarizes expression patterns for the selected mechanistic candidate genes.

### Cobalamin interaction analysis

```text
results/figures/cobalamin_cluster_interaction_log2FC.png
```

Shows interaction-effect log2 fold changes for the selected cobalamin-associated genes.

### Cobalamin strain response

```text
results/figures/cobalamin_cluster_strain_response.png
```

Shows strain-specific treatment responses within the cobalamin-associated cluster.

### SULP-region coverage

```text
results/figures/sulp_region_coverage.png
```

Shows read-coverage patterns across the selected SULP-associated genomic region.

Additional figures include:

```text
results/figures/
├── cobalamin_cluster_coverage_final.png
├── cobalamin_cluster_interaction_log2FC.png
├── cobalamin_cluster_strain_response.png
├── final_mechanistic_heatmap.png
├── mechanistic_candidates_treatment_effects.png
├── sulp_region_coverage.png
└── top20_interaction_genes.png
```

---

# Key Results Files

Important result tables include:

```text
results/counts/
├── DESeq2_interaction_results.tsv
├── DESeq2_interaction_validation.tsv
├── NK01067_meropenem_vs_control.tsv
├── dwbbM_meropenem_vs_control.tsv
├── count_matrix.tsv
├── normalized_counts.tsv
├── significant_interaction_genes.tsv
├── interaction_gene_summary.tsv
├── final_mechanistic_shortlist.tsv
├── mechanistic_shortlist.tsv
├── cobalamin_cluster_summary.tsv
└── sulp_region_candidates.tsv
```

### Normalized expression

```text
normalized_counts.tsv
```

contains normalized gene-expression values used for downstream interpretation and visualization.

### Interaction validation

```text
DESeq2_interaction_validation.tsv
```

contains the validation/summary analysis of the interaction results.

### Final mechanistic shortlist

```text
final_mechanistic_shortlist.tsv
```

contains the refined set of genes selected for mechanistic interpretation.

---

# Repository Structure

```text
klebsiella-transcriptome/
│
├── data/
│   └── metadata/
│       ├── SRP618458_runinfo.csv
│       ├── sample_metadata.tsv
│       ├── samples.csv
│       └── sra_metadata.tsv
│
├── docs/
│   └── full_results.md
│
├── reference/
│   ├── annotation/
│   │   ├── NK01067.gff
│   │   └── NK01067.gff.gz
│   │
│   └── genome/
│       ├── NK01067.fa
│       ├── NK01067.fa.gz
│       ├── NK01067.fa.fai
│       └── alignment index files
│
├── results/
│   ├── annotation/
│   │   ├── NDM1_reference.fa
│   │   └── NDM1_reference_protein.fa
│   │
│   ├── counts/
│   │   ├── differential-expression results
│   │   ├── interaction results
│   │   ├── candidate-gene lists
│   │   └── normalized counts
│   │
│   ├── coverage/
│   │   └── cobalamin_cluster_coverage.png
│   │
│   └── figures/
│       ├── cobalamin analysis
│       ├── mechanistic heatmap
│       ├── SULP-region analysis
│       └── treatment-response figures
│
├── scripts/
│   ├── classify_opposite_candidates.py
│   ├── count_remaining_samples.sh
│   ├── individual_treatment_DESeq2.R
│   ├── make_interaction_summary.R
│   ├── make_final_heatmap.R
│   └── make_normalized_counts.R
│
└── .gitignore
```

---

# Analysis Scripts

The `scripts/` directory contains code used for the analysis.

### Python

```text
classify_opposite_candidates.py
```

Used for classification of candidate genes according to their expression-response patterns.

### Shell

```text
count_remaining_samples.sh
```

Used for processing/counting remaining sequencing samples.

### R

```text
individual_treatment_DESeq2.R
make_interaction_summary.R
make_final_heatmap.R
make_normalized_counts.R
```

These scripts support differential-expression analysis, interaction summaries, normalized-count generation, and visualization.

---

# Reproducibility

The project is organized so that metadata, reference files, analysis scripts, statistical outputs, and figures are separated into dedicated directories.

The general workflow is:

```text
data/
   ↓
quality control
   ↓
reference alignment
   ↓
gene quantification
   ↓
count matrix
   ↓
DESeq2
   ↓
interaction analysis
   ↓
candidate classification
   ↓
focused mechanistic analyses
   ↓
figures
```

The repository intentionally separates generated results from analysis scripts to make it easier to identify which files represent raw inputs, intermediate outputs, and final results.

---

# Statistical Interpretation

The primary biological interpretation is based on the interaction between bacterial strain and meropenem treatment.

A significant interaction should be interpreted as evidence that the transcriptional response differs between the two strains under the tested conditions.

Differential expression and statistical association alone do not establish:

* direct molecular causation
* protein-level changes
* metabolic flux
* antibiotic resistance mechanism
* bacterial survival advantage

Such conclusions would require additional experimental validation.

The candidate genes and pathways identified in this analysis should therefore be considered hypotheses for further investigation.

---

# Data Source

The RNA-seq dataset is associated with:

**SRA Study:** SRP618458

The study investigates transcriptional changes associated with O-antigen deficiency and meropenem exposure in *Klebsiella pneumoniae*.

Sample-level metadata are included in:

```text
data/metadata/
```

The repository is intended to document the computational analysis performed on this dataset rather than reproduce the original experimental work.

---

# Scope and Limitations

This project is a computational transcriptomic analysis.

Important limitations include:

* RNA abundance does not necessarily correspond directly to protein abundance.
* Differential expression does not establish causality.
* The interaction analysis identifies strain-dependent transcriptional responses but does not by itself demonstrate the molecular mechanism responsible.
* Coverage analysis provides supporting genomic/transcriptomic evidence but should not be interpreted as proof of a functional mechanism.
* Mechanistic candidate selection involves biological interpretation in addition to statistical filtering.
* Experimental validation would be required to confirm specific mechanistic hypotheses.

---

# Future Directions

Potential follow-up analyses include:

* Functional enrichment of interaction genes
* KEGG pathway analysis
* Gene Ontology enrichment
* Operon-level analysis
* Genomic-context analysis of candidate loci
* Integration of transcriptomic and genomic information
* Comparison with additional *K. pneumoniae* datasets
* Validation of selected candidates using targeted molecular experiments
* Investigation of candidate pathways at the protein or metabolite level

---

# Author

**Alaa Abouzeeni**

Computational bacterial genomics and transcriptomics project focused on antimicrobial response, bacterial adaptation, and molecular mechanisms associated with antibiotic treatment.

---

## Project Status

**Analysis status:** Active research project

The repository contains completed differential-expression analyses, interaction analysis, candidate-gene prioritization, focused cobalamin and SULP-region analyses, and associated visualization outputs.

Additional analyses and refinements may be added as the project develops.
