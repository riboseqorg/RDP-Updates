// Import modules
include { FIND_AND_FETCH } from '../../../modules/local/find_and_fetch/main'
include { FINDING_RIBOSEQ } from '../../../modules/local/finding_riboseq/main'
include { COLUMN_CLEANUP } from '../../../modules/local/column_cleanup/main'
include { STANDARDISE_COLUMN_VALUES } from '../../../modules/local/standardise_column_values/main'
include { FINALISE_METADATA } from '../../../modules/local/finalise_metadata/main'

// Define the main workflow
workflow COLLECT {
    // Define input channels
    take:
        resources
        sraRunInfo

    main:
    // You might want to adjust these based on your specific input requirements
    // Call processes in the desired order
    FIND_AND_FETCH(            
        resources,
        sraRunInfo
        )

    FINDING_RIBOSEQ(
        params.resources,
        FIND_AND_FETCH.out.sra_info
        )
    COLUMN_CLEANUP(
        params.resources,
        FINDING_RIBOSEQ.out.all_columns
        )
    STANDARDISE_COLUMN_VALUES(
        params.resources,
        COLUMN_CLEANUP.out.filtered_riboseq
        )
    FINALISE_METADATA(
        params.resources,
        STANDARDISE_COLUMN_VALUES.out.standardised_values,
        STANDARDISE_COLUMN_VALUES.out.sra_ids,
        )


    emit:
    final_output = FINALISE_METADATA.out.final_metadata
}
