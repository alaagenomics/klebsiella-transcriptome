import pandas as pd

inp = "results/counts/opposite_direction_candidates.tsv"
out = "results/counts/opposite_direction_classified.tsv"

df = pd.read_csv(inp, sep="\t")

def classify(row):
    text = (
        str(row["gene_name"]) + " " +
        str(row["product"])
    ).lower()

    if any(x in text for x in [
        "flavohemoprotein", "nitric oxide", "nitrosative",
        "oxidative stress", "peroxide", "superoxide",
        "catalase", "peroxidase", "thioredoxin",
        "glutaredoxin", "ferredoxin"
    ]):
        return "Oxidative/nitrosative stress"

    if any(x in text for x in [
        "outer membrane", "lipoprotein", "peptidoglycan",
        "cell wall", "membrane protein", "lipopolysaccharide",
        "o-antigen", "envelope", "pilin", "pilotin"
    ]):
        return "Envelope/cell surface"

    if any(x in text for x in [
        "biofilm", "bssr", "fimbr", "adhesin", "curli"
    ]):
        return "Biofilm/adhesion"

    if any(x in text for x in [
        "dehydrogenase", "deaminase", "aminotransferase",
        "transaminase", "synthase", "synthetase",
        "metabolism", "metabolic", "kinase", "isomerase",
        "oxidoreductase", "transferase"
    ]):
        return "Metabolism"

    if any(x in text for x in [
        "transcription factor", "transcriptional regulator",
        "regulator", "repressor", "activator",
        "response regulator", "sigma factor"
    ]):
        return "Transcriptional regulation"

    if any(x in text for x in [
        "ribosomal protein", "ribosome", "translation",
        "trna", "rrna", "tRNA".lower()
    ]):
        return "Translation/ribosome"

    if any(x in text for x in [
        "dna repair", "repair protein", "recombinase",
        "helicase", "dna-binding", "single-stranded DNA",
        "radc", "hu-beta"
    ]):
        return "DNA repair/stress"

    if any(x in text for x in [
        "transporter", "transport", "permease",
        "channel", "efflux", "pump"
    ]):
        return "Transport"

    if any(x in text for x in [
        "toxin", "antitoxin", "toxin-antitoxin",
        "persistence"
    ]):
        return "Toxin-antitoxin/persistence"

    return "Other/unclear"

df["theme"] = df.apply(classify, axis=1)

df.to_csv(out, sep="\t", index=False)

print("Created:", out)
print()
print("Genes by theme:")
print(df["theme"].value_counts().to_string())
