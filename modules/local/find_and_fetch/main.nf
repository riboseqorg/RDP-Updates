

process FIND_AND_FETCH {
    container 'riboseq-collection:latest'
    publishDir "${params.outdir}/collection", mode: 'copy'

    input:
        path resources
        path sraRunInfo
    
    output:
        path "SraRunInfo", emit: sra_info
        path "bioprojects.csv", emit: bioprojects
    
    script:
    """
    Rscript \
        /usr/local/bin/metadata_find_fetch.R \
        -w resources/whitelisted_bioprojects.csv \
        -o SraRunInfo \
        -b bioprojects.csv 
    """
}
