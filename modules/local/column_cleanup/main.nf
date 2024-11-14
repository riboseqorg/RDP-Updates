

process COLUMN_CLEANUP {
    container 'riboseq-collection:latest'
    publishDir "${params.outdir}/collection", mode: 'copy'

    input:
        path resources
        path all_columns
    
    output:
        path "filtered_riboseq.csv", emit: filtered_riboseq

    
    script:
    """
    Rscript \
        /usr/local/bin/metadata_cleanup_columns.R \
        --input ${all_columns} \
        --resources-dir ${resources} \
        --output filtered_riboseq.csv
    """
}