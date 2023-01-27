process COMBGC {
    tag "$meta.id"

    conda "conda-forge::python=3.11.0 conda-forge::biopython=1.80 conda-forge::pandas=1.5.2"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/mulled-v2-27978155697a3671f3ef9aead4b5c823a02cc0b7:548df772fe13c0232a7eab1bc1deb98b495a05ab-0' :
        'quay.io/biocontainers/mulled-v2-27978155697a3671f3ef9aead4b5c823a02cc0b7:548df772fe13c0232a7eab1bc1deb98b495a05ab-0' }"

    input:
    tuple val(meta), path(input_paths)

    output:
    path "${prefix}/combgc_summary.tsv" , emit: tsv

    script: // This script is bundled with the pipeline, in nf-core/funcscan/bin/
    prefix = task.ext.prefix ?: "${meta.id}"
    """
    comBGC.py \\
        -i $input_paths \\
        -o $prefix
    """
}