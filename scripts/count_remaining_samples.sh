#!/bin/bash

set -e

ANNOTATION="reference/annotation/NK01067.gff"
COUNT_DIR="results/counts"

mkdir -p "$COUNT_DIR"

for sample in SRR35308234 SRR35308235 SRR35308236 SRR35308237 SRR35308238 SRR35308239 SRR35308240 SRR35308241 SRR35308242 SRR35308243 SRR35308244
do
    echo "===== Processing $sample ====="

    featureCounts \
        -T 4 \
        -p \
        --countReadPairs \
        -t gene \
        -g ID \
        -a "$ANNOTATION" \
        -o "$COUNT_DIR/${sample}.txt" \
        "results/alignment/${sample}.sorted.bam"

    echo "===== Finished $sample ====="
done
