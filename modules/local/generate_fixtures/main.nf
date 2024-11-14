

process GENERATE_FIXTURES {
    container 'riboseq-processing:latest'
    publishDir "${params.outdir}/processing", mode: 'copy'

    input:
        path prepared_metadata
        path rdp_sqlite
        path ribocrypt_metadata
        path trips_sample_matching
        path gwips_sample_matching
        path ribocrypt_process_status
        path rdp_vocabularies_main_name
        path collapsed_files
        path verified
        path geo_accessions
    
    output:
        path "riboseqorg_metadata_fixtures.json ", emit: fixtures

    script:
    """
    python \
        /app/Metadata/scripts/generate_fixtures.py  \
        -i ${prepared_metadata} \
        --db ${rdp_sqlite} \
        -o riboseqorg_metadata_fixtures.json  \
        -t ${trips_sample_matching}  \
        -g ${gwips_sample_matching}  \
        -r ${ribocrypt_process_status} \
        -c ${rdp_vocabularies_main_name} \
        -f ${collapsed_files} \
        -v ${verified} \
        --geo ${geo_accessions} \
    """
}