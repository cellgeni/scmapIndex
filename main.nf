#!/usr/bin/env nextflow

params.sce_folder = "."

Channel
    .fromPath( params.sce_folder )
    .ifEmpty { exit 1, "No input files found!" }
    .into { sce_files }

process scmap_cluster {
    publishDir "./scmap-cluster", mode: 'copy'

    input:
    file f from sce_files

    output:
    file "*.csv"

    script:
    """
    scmap_cluster.R ${f}
    """
}

process scmap_cell {
    publishDir "./scmap-cell", mode: 'copy'

    input:
    file f from sce_files

    output:
    file "*.rds"

    script:
    """
    scmap_cell.R ${f}
    """
}
