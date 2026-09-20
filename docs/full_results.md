# Full Results

## 1. RNA-seq processing and experimental design

Twelve paired-end RNA-seq samples representing two *Klebsiella pneumoniae* backgrounds (NK01067 and ΔwbbM) and two treatment conditions (control and meropenem), with three biological replicates per condition, were analyzed. Following read-quality assessment, reads were aligned to the NK01067 reference genome and quantified at the gene level using `featureCounts`. The resulting gene-level count matrix was analyzed using DESeq2.

A factorial differential-expression model incorporating strain, treatment, and the strain-by-treatment interaction was used to identify genes whose response to meropenem differed between the NK01067 and ΔwbbM backgrounds. The strain-by-treatment interaction therefore served as the primary measure of strain-dependent transcriptional responses to meropenem. Separate treatment contrasts within each strain were subsequently examined to determine the direction and magnitude of the response underlying significant interaction effects.

## 2. Genome-wide strain-dependent response to meropenem

The strain-by-treatment interaction analysis identified a broad transcriptional response to meropenem that differed between the NK01067 parental strain and the ΔwbbM mutant. Genes were considered to exhibit a significant strain-dependent response when the interaction term reached an adjusted *P* value below 0.05.

To focus the subsequent biological interpretation on genes showing clearly contrasting treatment responses, genes were further filtered according to the direction of their meropenem-associated expression change in each strain. This analysis identified 137 genes that were significantly differentially expressed following meropenem exposure in both strains but exhibited opposite directions of change between NK01067 and ΔwbbM. Thus, these genes represent responses in which meropenem-associated transcriptional changes differed qualitatively between the two genetic backgrounds.

A more stringent subset was then defined by requiring an interaction adjusted *P* value <0.001, significant treatment effects in both strains (*P*adj <0.05), and an absolute treatment-associated log2 fold change of at least 0.5 in each strain. This filtering yielded 76 high-confidence genes. The largest functional categories among these genes were metabolism (17 genes), transport/secretion (14 genes), uncharacterized proteins (12 genes), and translation/ribosome-associated functions (9 genes). Additional candidates were associated with the cell envelope, nitrogen/nutrient responses, cobalamin/cofactor metabolism, oxidative/redox stress, transcriptional regulation, and other cellular processes.

Overall, the interaction analysis indicates that the ΔwbbM mutation is associated with a substantially different transcriptional response to meropenem across multiple functional categories rather than a change restricted to a single pathway.

## 3. Strain-specific treatment responses

To interpret the interaction results, treatment effects were also analyzed separately within each strain.

In NK01067, 3,374 genes were significant at an adjusted *P* value <0.05 in the meropenem-versus-control comparison. In ΔwbbM, 3,033 genes were significant at the same threshold.

These strain-specific contrasts were used to determine the direction and magnitude of treatment-associated expression changes underlying the strain-by-treatment interaction.

Several genes showed particularly strong differences in response magnitude or direction between the two strains.

### dsdA

M8Y62_00125 (`dsdA`) encodes D-serine ammonia-lyase. It showed strong induction in both backgrounds, but the magnitude of induction differed substantially:

* NK01067: log2FC = +4.484
* ΔwbbM: log2FC = +1.020

Thus, `dsdA` was induced following meropenem exposure in both strains, but much more strongly in NK01067.

### dsdX

M8Y62_00130 (`dsdX`) encodes a D-serine transporter. Its treatment-associated expression changes were:

* NK01067: log2FC = +4.720
* ΔwbbM: log2FC = +1.513

As with `dsdA`, the response was in the same direction in both strains but differed substantially in magnitude.

### tisB

M8Y62_00160 (`tisB`) encodes the TisB toxin associated with a type I toxin-antitoxin system. It showed opposite treatment responses:

* NK01067: log2FC = −0.924
* ΔwbbM: log2FC = +0.722

This opposite-direction response indicates a strain-dependent transcriptional response to meropenem.

Expression of `tisB` alone, however, does not establish a change in bacterial persistence.

## 4. High-confidence interaction candidates

The 76 high-confidence candidates were identified using the following criteria:

* interaction padj <0.001;
* NK01067 treatment padj <0.05;
* ΔwbbM treatment padj <0.05;
* absolute NK01067 treatment log2FC ≥0.5;
* absolute ΔwbbM treatment log2FC ≥0.5.

The final table is stored as:

`results/counts/high_confidence_candidates_final.tsv`

The table contains the gene identifier, gene annotation, curated functional theme, interaction effect, and strain-specific treatment effects.

The 76 candidates were distributed across multiple functional categories, with the largest groups being metabolism, transport/secretion, uncharacterized proteins, and translation/ribosome-associated functions.

## 5. Functional classification of high-confidence candidates

The 76 high-confidence genes were manually curated into functional themes.

| Functional theme                          | Number of genes |
| ----------------------------------------- | --------------: |
| Metabolism                                |              17 |
| Transport/secretion                       |              14 |
| Uncharacterized                           |              12 |
| Translation/ribosome                      |               9 |
| Envelope/LPS/cell wall                    |               4 |
| Nitrogen/nutrient response                |               3 |
| Cobalamin/cofactor metabolism             |               3 |
| Protein folding/quality stress            |               2 |
| Oxidative/redox stress                    |               2 |
| Transcriptional regulation                |               2 |
| DNA repair/stress                         |               1 |
| Mobile genetic elements/genome plasticity |               1 |
| Toxin-antitoxin/persistence               |               1 |
| Biofilm/adhesion                          |               1 |
| RNA/stress response                       |               1 |
| Regulation/signal transduction            |               1 |
| Respiration/electron transport            |               1 |
| Carbohydrate metabolism                   |               1 |

The functional classification was used to organize the biological interpretation of the candidate genes. Functional categories do not imply that all genes within a category have identical physiological roles.

## 6. Cobalamin/cobalt-associated genomic region

Several high-confidence interaction genes were concentrated within a compact genomic region containing genes associated with cobalamin biosynthesis and cobalt acquisition. The region included M8Y62_04655, M8Y62_04660, M8Y62_04670, M8Y62_04675, M8Y62_04685, M8Y62_04690, M8Y62_04695, and M8Y62_04700.

The encoded functions included cobalt-precorrin processing, sirohydrochlorin cobaltochelatase, an ECF cobalt transporter, cobyric acid synthase, CobU, and CobT.

These genes displayed a coordinated strain-dependent response to meropenem. In the NK01067 background, expression of the genes in this region generally decreased following meropenem exposure, whereas expression increased in the ΔwbbM background.

For example, M8Y62_04690, encoding cobyric acid synthase, showed a log2 fold change of −1.816 in NK01067 compared with +0.872 in ΔwbbM. The interaction log2 fold change was +2.695 with an adjusted *P* value of 1.90 × 10⁻¹².

M8Y62_04695 (`cobU`) showed a log2 fold change of −1.499 in NK01067 and +1.271 in ΔwbbM, with an interaction log2 fold change of +2.778 and an adjusted *P* value of 1.16 × 10⁻⁹.

The genomic organization further supported the coordinated nature of this response. M8Y62_04655 through M8Y62_04700 form a dense genomic neighborhood, with several adjacent genes separated by very short intergenic distances or overlapping gene boundaries.

The nearby M8Y62_04705 is annotated as a tRNA-Met gene on the opposite strand and was therefore not treated as part of the protein-coding cobalamin cluster.

RNA-seq coverage was detected throughout the examined region across the 12 samples, supporting transcriptional activity across the locus. However, genomic organization and coverage alone do not establish that all genes are transcribed as a single operon.

### Normalized expression of the cobalamin-associated region

Normalized expression further demonstrated the contrasting response of the region.

The mean normalized expression across the eight protein-coding genes was approximately:

| Condition         | Mean normalized expression |
| ----------------- | -------------------------: |
| NK01067 control   |                       1396 |
| NK01067 meropenem |                        554 |
| ΔwbbM control     |                       1229 |
| ΔwbbM meropenem   |                       2462 |

Thus, the cluster showed a contrasting transcriptional response between the parental and ΔwbbM backgrounds.

These findings indicate that multiple genes within a compact cobalamin/cobalt-associated genomic region undergo coordinated strain-dependent transcriptional changes following meropenem exposure.

Increased transcript abundance should not, however, be interpreted as direct evidence of increased cobalamin production.

## 7. Genomic neighborhood analysis

The genomic organization of high-confidence candidates was examined to identify groups of nearby genes.

Using a 1-kb clustering criterion, nine genomic clusters containing 25 of the 76 high-confidence genes were identified.

The major clusters were:

1. M8Y62_04655–M8Y62_04705 — cobalamin/cobalt-associated region
2. M8Y62_07960–M8Y62_07965 — `glpB` and `glpA`
3. M8Y62_10975–M8Y62_10980 — `rpmI` and `rplT`
4. M8Y62_16240–M8Y62_16245 — `rpmF` and `yceD`
5. M8Y62_17605–M8Y62_17610 — `hlyD` and an ABC domain protein
6. M8Y62_19550–M8Y62_19555 — ABC permease and ATP-binding components
7. M8Y62_22845–M8Y62_22850 — AAA-domain protein and hypothetical protein
8. M8Y62_23065–M8Y62_23070 — carbonic anhydrase and SulP transporter
9. M8Y62_25575–M8Y62_25580 — `glnL` and `glnG`

Genomic proximity was interpreted as evidence supporting possible coordinated regulation, not as definitive proof of operon structure.

## 8. Carbonic anhydrase–SulP region

M8Y62_23065 and M8Y62_23070 form a compact same-strand genomic pair.

M8Y62_23065 encodes a carbonic anhydrase, while M8Y62_23070 encodes a SulP family inorganic anion transporter. The latter is annotated with sulfate transport and sulfate transmembrane transporter functions.

The two genes overlap by approximately 4 bp in the reference annotation.

Both genes showed strong strain-dependent treatment responses.

### Carbonic anhydrase — M8Y62_23065

* NK01067: log2FC = +0.700
* ΔwbbM: log2FC = −2.197
* interaction log2FC = −2.891
* interaction padj = 4.76 × 10⁻¹³

### SulP transporter — M8Y62_23070

* NK01067: log2FC = +1.920
* ΔwbbM: log2FC = −1.574
* interaction log2FC = −3.490
* interaction padj = 2.13 × 10⁻¹⁵

The SulP transporter therefore exhibited one of the strongest interaction effects in the dataset.

RNA-seq coverage was detected across the examined region in all 12 samples, supporting transcriptional activity across the locus.

The combination of genomic proximity, shared strand orientation, continuous coverage, and coordinated strain-dependent expression is consistent with coordinated transcriptional regulation. However, these data alone do not establish an operon or determine the physiological consequences of the expression changes.

## 9. Redox and stress-response genes

Several candidates were associated with redox homeostasis and stress responses. These included:

* M8Y62_01980 (`bfd`) — bacterioferritin-associated ferredoxin
* M8Y62_06170 (`hmpA`) — NO-inducible flavohemoprotein
* M8Y62_17300 — GrxA-family glutaredoxin
* M8Y62_18475 (`ahpC`) — alkyl hydroperoxide reductase subunit C

These genes were distributed across different genomic locations rather than forming a single genomic cluster.

### hmpA

M8Y62_06170 (`hmpA`) showed:

* NK01067: log2FC = +0.454
* ΔwbbM: log2FC = −1.131
* interaction log2FC = −1.583

Thus, meropenem exposure was associated with induction of `hmpA` in NK01067 but reduced expression in ΔwbbM.

### ahpC

M8Y62_18475 (`ahpC`) showed:

* NK01067: log2FC = −0.473
* ΔwbbM: log2FC = +0.588
* interaction log2FC = +1.064

This represented an opposite-direction response compared with `hmpA`.

### GrxA-family glutaredoxin

M8Y62_17300 showed:

* NK01067: log2FC = −0.846
* ΔwbbM: log2FC = +0.445
* interaction log2FC = +1.294

### bfd

M8Y62_01980 (`bfd`) showed:

* NK01067: log2FC = −1.140
* ΔwbbM: log2FC = +0.664
* interaction log2FC = +1.806

Together, these observations indicate that multiple redox- and stress-associated genes exhibit different transcriptional responses to meropenem depending on the bacterial genetic background.

RNA-seq expression alone does not directly measure intracellular ROS, nitric oxide concentrations, oxidative damage, or bacterial killing.

## 10. Additional functional groups

### Envelope and cell-wall-associated genes

Several candidates were associated with the bacterial envelope, including:

* M8Y62_21340 — YacC family pilotin-like protein
* M8Y62_16300 — lipoprotein
* M8Y62_17495 — OmpX
* M8Y62_24300 — PspG
* M8Y62_17985 — Pal
* M8Y62_10210 — Slp family lipoprotein
* M8Y62_05965 — BamD
* M8Y62_01410 — DcrB family lipoprotein
* M8Y62_21555 — FtsI
* M8Y62_03015 — DedA family protein
* M8Y62_05565 — LpxO

FtsI is particularly relevant to peptidoglycan synthesis and beta-lactam biology. However, expression changes alone do not establish altered beta-lactam susceptibility or resistance.

### Transport and secretion

The high-confidence set included multiple transport and secretion-associated genes, including generic ABC transporter components, P-type ATPases, and secretion-associated proteins.

Specific substrate assignments were not made for generic ABC transporter components unless supported by their annotations.

### Translation and ribosome-associated genes

Multiple ribosomal proteins and translation-associated factors were identified, including:

* `rpmE`
* `infC`
* `thrS`
* `rpsU`
* `rplT`
* `rpmF`
* `rpmI`
* `ygfZ`
* `rbfA`
* `rplX`
* `rpsI`
* `rplS`
* `rpmJ`
* `rpsM`
* `dtd`
* `pheT`
* `rplL`
* `rpsD`

These findings indicate strain-dependent changes in expression of translation-associated genes. They do not by themselves demonstrate increased or decreased translation rates.

### Nitrogen and nutrient response

Several genes were associated with nitrogen or nutrient regulation, including `glnG`, `glnL`, and `psiE`.

The `glnG`/`glnL` pair forms a compact genomic neighborhood and showed strain-dependent expression responses.

### Mobile genetic elements and genome plasticity

A small number of candidates were associated with mobile genetic elements or genome plasticity, including genes annotated as recombination-promoting nuclease/putative transposase and a tyrosine-type DNA invertase.

Their differential expression indicates transcriptional changes in these loci but does not demonstrate increased genome rearrangement or transposition.

## 11. Overall interpretation

The transcriptomic analysis demonstrates that the NK01067 parental strain and ΔwbbM mutant exhibit distinct transcriptional responses to meropenem.

The strain-dependent response involves multiple biological processes rather than a single pathway. Particularly notable features include:

* contrasting regulation of a compact cobalamin/cobalt-associated genomic region;
* a strong opposite-direction response involving carbonic anhydrase and a SulP family transporter;
* multiple strain-dependent redox and stress-response genes;
* changes involving transport and secretion;
* envelope-associated genes;
* nutrient and nitrogen responses;
* translation-associated genes;
* and broader metabolic remodeling.

The cobalamin/cobalt-associated region and the carbonic anhydrase–SulP pair provide particularly clear examples in which differential expression is supported by genomic organization and RNA-seq coverage.

Together, these findings support a model in which O-antigen deficiency is associated with broad remodeling of the transcriptional response to meropenem.

These results should be considered hypothesis-generating for future mechanistic experiments. Direct measurements of antibiotic susceptibility, intracellular metabolites, redox state, ROS/NO levels, protein abundance, and other physiological phenotypes would be required to establish the functional consequences of the observed transcriptional changes.

## 12. Data and analysis outputs

The major analysis outputs are organized as follows:

```text
results/
├── alignment/
├── qc/
├── counts/
│   ├── gene_counts.txt
│   ├── count_matrix.tsv
│   ├── DESeq2_interaction_results.tsv
│   ├── significant_interaction_genes.tsv
│   ├── significant_interaction_negative.tsv
│   ├── significant_interaction_positive.tsv
│   ├── opposite_direction_candidates.tsv
│   ├── opposite_direction_curated.tsv
│   ├── opposite_direction_strong_candidates.tsv
│   ├── high_confidence_candidates.tsv
│   ├── high_confidence_candidates_final.tsv
│   ├── high_confidence_by_theme.tsv
│   ├── top_interaction_candidates.tsv
│   └── key_genes_treatment_effects.tsv
│
├── coverage/
│   ├── cobalamin-associated region
│   ├── sulP cluster
│   └── redox candidates
│
└── figures/
    ├── mechanistic_candidates_treatment_effects.png
    ├── cobalamin_cluster_coverage_final.png
    └── top20_interaction_genes.png
```

The complete high-confidence candidate table is:

`results/counts/high_confidence_candidates_final.tsv`

This table should be used as the primary supplementary candidate table for the current analysis.

## 13. Limitations

The following limitations should be considered when interpreting the results:

1. RNA-seq measures transcript abundance and does not directly measure protein abundance or activity.
2. Differential expression does not establish causality.
3. Increased expression of cobalamin-associated genes does not prove increased cobalamin production.
4. Stress-response gene expression does not directly measure ROS or nitric oxide concentrations.
5. Expression changes do not by themselves establish increased or decreased meropenem resistance.
6. Genomic proximity and continuous RNA-seq coverage do not prove operon structure.
7. Generic transporter annotations should not be assigned specific substrates without additional evidence.
8. Toxin-antitoxin gene expression does not directly establish persistence.
9. Biofilm-associated gene expression does not establish a change in biofilm formation.
10. Functional hypotheses generated from transcriptomic data require experimental validation.

## 14. Conclusion

This RNA-seq analysis identifies a broad and strain-dependent transcriptional response to meropenem in *K. pneumoniae*. The ΔwbbM mutant differs from the NK01067 parental strain across metabolic, transport, envelope, nutrient, stress-response, and regulatory functions.

A stringent analysis identified 76 high-confidence genes with significant strain-dependent treatment responses. Among these, a compact cobalamin/cobalt-associated region and the carbonic anhydrase–SulP genomic pair showed particularly strong and coordinated responses supported by both differential-expression and genomic-context analyses.

The dataset therefore provides a framework for investigating how alteration of O-antigen-associated biology influences bacterial transcriptional adaptation during meropenem exposure.

