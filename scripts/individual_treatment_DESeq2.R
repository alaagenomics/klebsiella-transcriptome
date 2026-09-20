library(DESeq2)

# -----------------------------
# 1. Read count matrix
# -----------------------------
counts <- read.delim(
  "results/counts/count_matrix.tsv",
  row.names = 1,
  check.names = FALSE
)

# -----------------------------
# 2. Read sample metadata
# -----------------------------
metadata <- read.csv(
  "data/metadata/samples.csv",
  stringsAsFactors = FALSE
)

rownames(metadata) <- metadata$sample

# -----------------------------
# 3. Make sure count columns
#    match metadata samples
# -----------------------------
counts <- counts[, metadata$sample]

# -----------------------------
# 4. Convert variables to factors
# -----------------------------
metadata$strain <- factor(
  metadata$strain,
  levels = c("NK01067", "dwbbM")
)

metadata$treatment <- factor(
  metadata$treatment,
  levels = c("control", "meropenem")
)

# -----------------------------
# 5. Function for each strain
# -----------------------------
run_strain_DE <- function(strain_name) {

  cat("\n====================================\n")
  cat("STRAIN:", strain_name, "\n")
  cat("====================================\n")

  keep <- metadata$strain == strain_name

  count_sub <- counts[, keep]
  meta_sub <- metadata[keep, ]

  # Make sure metadata and count matrix have same order
  count_sub <- count_sub[, rownames(meta_sub)]

  dds <- DESeqDataSetFromMatrix(
    countData = round(count_sub),
    colData = meta_sub,
    design = ~ treatment
  )

  # Remove genes with essentially no counts
  dds <- dds[rowSums(counts(dds)) >= 10, ]

  # Run DESeq2
  dds <- DESeq(dds)

  # Meropenem vs control
  res <- results(
    dds,
    contrast = c("treatment", "meropenem", "control")
  )

  # Sort by adjusted p-value
  res <- res[order(res$padj), ]

  # Add gene ID as column
  res$Geneid <- rownames(res)

  # Put Geneid first
  res <- res[, c(
    "Geneid",
    "baseMean",
    "log2FoldChange",
    "lfcSE",
    "stat",
    "pvalue",
    "padj"
  )]

  output_file <- paste0(
    "results/counts/",
    strain_name,
    "_meropenem_vs_control.tsv"
  )

  write.table(
    res,
    output_file,
    sep = "\t",
    quote = FALSE,
    row.names = FALSE,
    na = ""
  )

  cat("Saved:", output_file, "\n")
  cat("Genes tested:", nrow(res), "\n")
  cat("Significant genes (padj < 0.05):",
      sum(res$padj < 0.05, na.rm = TRUE), "\n")

  return(res)
}

# -----------------------------
# 6. Run both strains
# -----------------------------
res_NK01067 <- run_strain_DE("NK01067")
res_dwbbM <- run_strain_DE("dwbbM")

# -----------------------------
# 7. Extract the three genes
#    we are interested in
# -----------------------------
genes_of_interest <- c(
  "M8Y62_00125",
  "M8Y62_00130",
  "M8Y62_00160"
)

key_NK <- res_NK01067[
  res_NK01067$Geneid %in% genes_of_interest,
]

key_dwbbM <- res_dwbbM[
  res_dwbbM$Geneid %in% genes_of_interest,
]

# Add strain labels
key_NK$strain <- "NK01067"
key_dwbbM$strain <- "dwbbM"

key_results <- rbind(
  key_NK,
  key_dwbbM
)

# Reorder columns
key_results <- key_results[, c(
  "Geneid",
  "strain",
  "baseMean",
  "log2FoldChange",
  "lfcSE",
  "stat",
  "pvalue",
  "padj"
)]

write.table(
  key_results,
  "results/counts/key_genes_treatment_effects.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE,
  na = ""
)

cat("\n====================================\n")
cat("KEY GENES\n")
cat("====================================\n")
print(key_results)

cat("\nSaved: results/counts/key_genes_treatment_effects.tsv\n")
