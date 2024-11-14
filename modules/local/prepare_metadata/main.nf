

process PREPARE_METADATA {
    container 'riboseq-processing:latest'
    publishDir "${params.outdir}/processing", mode: 'copy'

    input:
        path fetched_metadata
        path ribocrypt_metadata
    
    output:
        path "prepared_metadata.csv", emit: prepared_metadata

    script:
    """
    python \
        /app/Metadata/scripts/prepare_metadata.py \
        ${fetched_metadata} \
        prepared_metadata.csv \
        --ribocrypt ${ribocrypt_metadata}
    """
}