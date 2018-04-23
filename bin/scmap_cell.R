#!/usr/bin/env Rscript

library(scmap)
library(scater)
library(SingleCellExperiment)

args <- commandArgs(trailingOnly = TRUE)

sce <- readRDS(args[1])

# this function writes to logcounts slot
exprs(sce) <- log2(calculateCPM(sce, use.size.factors = FALSE) + 1)
# use gene names as feature symbols
rowData(sce)$feature_symbol <- rownames(sce)
# remove features with duplicated names
if(is.null(rowData)) {
    sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]
}
# QC
isSpike(sce, "ERCC") <- grepl("^ERCC-", rownames(sce))

# scmap requires cell_type1 column for the reference
colnames(colData(sce))[grepl("ClusterID", colnames(colData(sce)))] <- "cell_type1"

sce <- indexCell(sce)
saveRDS(
    metadata(sce)$scmap_cell_index,
    file = paste0(strsplit(args[1], "\\.")[[1]][1], ".rds")
)
