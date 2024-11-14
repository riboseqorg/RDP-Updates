#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Import processes from modules
include { COLLECT } from './workflows/local/collection/main'
include { PROCESS } from './workflows/local/processing/main'

// Parameter definitions with defaults
params.outdir = 'results'
params.sraRunInfo = "/home/jack/projects/RDP-Updates/data/SraRunInfo"
params.resources = "/home/jack/projects/RDP-Updates/data/resources"
params.ribocrypt_metadata = "/home/jack/projects/Metadata/data/RiboCrypt_Metadata_13_09_24.csv"
params.rdp_sqlite = "/home/jack/projects/RDP-Updates/data/db.sqlite3"
params.trips_sample_matching = "/home/jack/projects/Metadata/data/Sample_Matching-Trips-Viz.csv"
params.gwips_sample_matching = "/home/jack/projects/Metadata/data/Sample_Matching-GWIPS-Viz.csv"
params.ribocrypt_process_status = "/home/jack/projects/Metadata/data/rc_supported_samples_with_status.csv"
params.rdp_vocabularies_main_name = "/home/jack/projects/Metadata/data/RiboSeqOrg_Vocabularies-Main_Name_Cleaning.csv"
params.collapsed_files = "/home/jack/projects/Metadata/data/collapsed_runs_16_09_24.txt"
params.verified = "/home/jack/projects/Metadata/data/verified.csv"
params.geo_accessions = "/home/jack/projects/Metadata/data/all_GEO_accesions.csv"
params.collect_output = null  // New parameter for skipping COLLECT

params.timestamp = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date())

log.info """
         RiboSeq Data Portal Update Pipeline
         ===================================
         outdir         : ${params.outdir}
         timestamp      : ${params.timestamp}
         collect_output : ${params.collect_output ?: 'Not provided (will run COLLECT)'}
         """

// Main workflow
workflow {
    main:
        if (params.collect_output) {
            // Use the provided collect_output
            collected_metadata = Channel.fromPath(params.collect_output)
        } else {
            // Run the collection process
            collected_metadata = COLLECT(
                params.resources,
                params.sraRunInfo
            ).final_output
        }
        
        // Process the collected data
        PROCESS(
            collected_metadata,
            params.ribocrypt_metadata,
            params.rdp_sqlite,
            params.trips_sample_matching,
            params.gwips_sample_matching,
            params.ribocrypt_process_status,
            params.rdp_vocabularies_main_name,
            params.collapsed_files,
            params.verified,
            params.geo_accessions,
        )
}

// Completion handler
workflow.onComplete {
    log.info "Pipeline completed at: $workflow.complete"
    log.info "Execution status: ${ workflow.success ? 'SUCCESS' : 'FAILED' }"
    log.info "Execution duration: $workflow.duration"
}

// Error handler
workflow.onError {
    log.error "Workflow execution failed"
    log.error "Error message: ${workflow.errorMessage}"
}