#!/usr/bin/env Rscript

library(scmap)
library(SingleCellExperiment)

args <- commandArgs(trailingOnly = TRUE)

sce <- readRDS(args[1])
rowData(sce)$feature_symbol <- rownames(counts(sce))

sce <- selectFeatures(sce, suppress_plot = FALSE)

sce <- indexCell(sce)
saveRDS(
    metadata(sce)$scmap_cell_index,
    file = paste(strsplit("\\.", args[1])[[1]][1], ".rds")
)
