

process FINALISE_METADATA {
    container 'riboseq-collection:latest'
    publishDir "${params.outdir}/collection", mode: 'copy'

    input:
        path resources
        path standardised_values
        path sra_ids
    
    output:
        path "standardized_columns_final*.csv", emit: final_metadata

    script:
    """
    Rscript \
        /usr/local/bin/metadata_standardized_columns_post_cleanup.R \
        --input ${standardised_values} \
        --resources-dir ${resources} \
        --sra-ids ${sra_ids} \
        --output-dir .
    """
}