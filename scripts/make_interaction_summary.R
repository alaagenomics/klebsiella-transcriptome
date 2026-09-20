# -----------------------------
# 1. Read interaction results
# -----------------------------
interaction <- read.delim(
  "results/counts/DESeq2_interaction_results.tsv",
  check.names = FALSE,
  stringsAsFactors = FALSE
)

colnames(interaction)[1] <- "Geneid"

interaction_sig <- interaction[
  !is.na(interaction$padj) & interaction$padj < 0.05,
]

# -----------------------------
# 2. Read individual results
# -----------------------------
nk <- read.delim(
  "results/counts/NK01067_meropenem_vs_control.tsv",
  check.names = FALSE,
  stringsAsFactors = FALSE
)

dw <- read.delim(
  "results/counts/dwbbM_meropenem_vs_control.tsv",
  check.names = FALSE,
  stringsAsFactors = FALSE
)

colnames(nk)[1] <- "Geneid"
colnames(dw)[1] <- "Geneid"

nk_small <- nk[, c("Geneid", "log2FoldChange", "padj")]
colnames(nk_small) <- c(
  "Geneid",
  "NK01067_log2FC",
  "NK01067_padj"
)

dw_small <- dw[, c("Geneid", "log2FoldChange", "padj")]
colnames(dw_small) <- c(
  "Geneid",
  "dwbbM_log2FC",
  "dwbbM_padj"
)

# -----------------------------
# 3. Read GFF
# -----------------------------
gff <- read.delim(
  "reference/annotation/NK01067.gff",
  sep = "\t",
  header = FALSE,
  comment.char = "#",
  quote = "",
  fill = TRUE,
  stringsAsFactors = FALSE
)

colnames(gff) <- c(
  "seqid",
  "source",
  "type",
  "start",
  "end",
  "score",
  "strand",
  "phase",
  "attributes"
)

# -----------------------------
# 4. Extract gene annotations
# -----------------------------
genes <- gff[gff$type == "gene", ]

genes$Geneid <- sub(
  ".*locus_tag=([^;]+).*",
  "\\1",
  genes$attributes
)

genes$gene_name <- sub(
  ".*Name=([^;]+).*",
  "\\1",
  genes$attributes
)

# -----------------------------
# 5. Extract CDS products
# -----------------------------
cds <- gff[gff$type == "CDS", ]

cds$Geneid <- sub(
  ".*Parent=gene-([^;]+).*",
  "\\1",
  cds$attributes
)

cds$product <- sub(
  ".*product=([^;]+).*",
  "\\1",
  cds$attributes
)

# Keep only valid products
cds$product[
  !grepl("product=", cds$attributes)
] <- NA

# One product per gene
products <- cds[!duplicated(cds$Geneid), c(
  "Geneid",
  "product"
)]

# -----------------------------
# 6. Combine annotation
# -----------------------------
annotation <- merge(
  genes[, c("Geneid", "gene_name")],
  products,
  by = "Geneid",
  all.x = TRUE
)

# -----------------------------
# 7. Combine DESeq2 results
# -----------------------------
summary <- merge(
  interaction_sig,
  nk_small,
  by = "Geneid",
  all.x = TRUE
)

summary <- merge(
  summary,
  dw_small,
  by = "Geneid",
  all.x = TRUE
)

summary <- merge(
  annotation,
  summary,
  by = "Geneid",
  all.x = FALSE
)

# -----------------------------
# 8. Rename interaction columns
# -----------------------------
colnames(summary)[
  colnames(summary) == "log2FoldChange"
] <- "interaction_log2FC"

colnames(summary)[
  colnames(summary) == "padj"
] <- "interaction_padj"

# -----------------------------
# 9. Keep useful columns
# -----------------------------
summary <- summary[, c(
  "Geneid",
  "gene_name",
  "product",
  "interaction_log2FC",
  "interaction_padj",
  "NK01067_log2FC",
  "NK01067_padj",
  "dwbbM_log2FC",
  "dwbbM_padj"
)]

# Sort by interaction adjusted p-value
summary <- summary[
  order(summary$interaction_padj),
]

# -----------------------------
# 10. Save
# -----------------------------
write.table(
  summary,
  "results/counts/interaction_gene_summary.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE,
  na = ""
)

cat("\n====================================\n")
cat("SUMMARY CREATED SUCCESSFULLY\n")
cat("====================================\n")
cat("Significant interaction genes:", nrow(summary), "\n")
cat("Output: results/counts/interaction_gene_summary.tsv\n\n")

print(head(summary, 10))
