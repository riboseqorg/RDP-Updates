

process LOAD_DATA {
    container 'riboseq-data-portal:latest'
    publishDir "${params.outdir}/database", mode: 'copy'

    input:
        path metadata_json

    output:
        path "db.sqlite3", emit: db

    script:
    """
    python3 /app/riboseqorg/manage.py flush --no-input &&
    python3 /app/riboseqorg/manage.py makemigrations && \
    python3 /app/riboseqorg/manage.py migrate && \
    python3 /app/riboseqorg/manage.py loaddata $metadata_json

    mv /app/riboseqorg/db.sqlite3 .
    """
}