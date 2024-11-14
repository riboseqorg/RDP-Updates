

process FINDING_RIBOSEQ {
    container 'riboseq-collection:latest'
    publishDir "${params.outdir}/collection", mode: 'copy'

    input:
        path resources
        path sraRunInfo
    
    output:
        path "outputs", emit: outputs
        path "outputs/RiboSeq_Metadata_All_Columns.csv", emit: all_columns
    
    script:
    """
    Rscript \
        /usr/local/bin/finding_riboseq.R \
        --input-dir SraRunInfo \
        --whitelist resources/whitelisted_samples.csv \
        --output-dir outputs
    """
}