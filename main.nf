#!/usr/bin/env nextflow

params.sce_folder = "sce-objects"

Channel
    .fromPath( params.sce_folder + '/*.rds' )
    .ifEmpty { exit 1, "No input files found!" }
    .into { sce_files_cluster; scmap_files_cell }

process scmap_cluster {
    tag "${f}"

    publishDir "./scmap-cluster", mode: 'copy'

    input:
    file f from sce_files_cluster

    output:
    file "*.csv"

    script:
    """
    scmap_cluster.R ${f}
    """
}

process scmap_cell {
    tag "${f}"
    
    publishDir "./scmap-cell", mode: 'copy'

    input:
    file f from scmap_files_cell

    output:
    file "*.rds"

    script:
    """
    scmap_cell.R ${f}
    """
}
