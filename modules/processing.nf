

process PROCESS {
    container 'your-org/riboseq-processing:latest'
    publishDir "${params.outdir}/processed", mode: 'copy'
    
    input:
        path metadata_csv
        
    output:
        path "fixtures/*", emit: fixtures
        path "logs/*", emit: logs
    
    script:
    """
    mkdir -p logs fixtures
    
    # The container's entrypoint will handle processing
    """
}