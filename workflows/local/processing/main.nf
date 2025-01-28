// Import modules
include { PREPARE_METADATA } from '../../../modules/local/prepare_metadata/main'
include { GENERATE_FIXTURES } from '../../../modules/local/generate_fixtures/main'

// Define the main workflow
workflow PROCESS {
    // Define input channels
    take:
        fetched_metadata
        ribocrypt_metadata
        rdp_sqlite
        trips_sample_matching
        gwips_sample_matching
        ribocrypt_process_status
        rdp_vocabularies_main_name
        collapsed_files
        verified
        geo_accessions

    main:
    // You might want to adjust these based on your specific input requirements
    // Call processes in the desired order
    PREPARE_METADATA(            
        fetched_metadata,
        ribocrypt_metadata
        )
    
    GENERATE_FIXTURES(
        PREPARE_METADATA.out.prepared_metadata,
        rdp_sqlite,
        ribocrypt_metadata,
        trips_sample_matching,
        gwips_sample_matching,
        ribocrypt_process_status,
        rdp_vocabularies_main_name,
        collapsed_files,
        verified,
        geo_accessions,
    )

    emit:
    metadata = GENERATE_FIXTURES.out.fixtures
}
