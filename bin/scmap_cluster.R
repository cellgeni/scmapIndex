#!/usr/bin/env Rscript

library(scmap)
library(SingleCellExperiment)

args <- commandArgs(trailingOnly = TRUE)

sce <- readRDS(args[1])
rowData(d)$feature_symbol <- rownames(counts(d))

sce <- selectFeatures(sce, suppress_plot = FALSE)

sce <- indexCluster(sce)
write.csv(
    metadata(sce)$scmap_cluster_index, 
    quote = F,
    file = paste(strsplit("\\.", args[1])[[1]][1], ".csv")
)
