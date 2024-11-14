


process COLLECT {
    container 'riboseq-collection:latest'
    publishDir "${params.outdir}/collection", mode: 'copy'

    input:
        path temp_dir
        path resources
        path sraRunInfo
    
    output:
        path "temp_files/standardized_columns_final_2024-04-22.csv", emit: metadata_csv
        path "temp_files/*", emit: temp_files
        path "SraRunInfo/*", emit: sra_info
        path "*.log", emit: logs
    
    script:
    """
    Rscript \
        /usr/local/bin/metadata_main_script.R \
        --output output \
        --temp temp_files \
        --sra SraRunInfo \
        --scripts /usr/local/bin > output.txt
    """
}
