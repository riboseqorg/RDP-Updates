

process STANDARDISE_COLUMN_VALUES {
    container 'riboseq-collection:latest'
    publishDir "${params.outdir}/collection", mode: 'copy'

    input:
        path resources
        path filtered_riboseq
    
    output:
        path "standardised_values.csv", emit: standardised_values
        path "SRA_ids.csv", emit: sra_ids

    script:
    """
    Rscript \
        /usr/local/bin/metadata_standardize_column_values.R \
        --input ${filtered_riboseq} \
        --resources-dir ${resources} \
        --output standardised_values.csv \
        --sra-output SRA_ids.csv
    """
}