#!/usr/bin/env nextflow
// Include processes
include { QCONTROL }        from './processes/qcontrol.nf'
include { TRIM }            from './processes/trim.nf'
include { REPORT }          from './processes/report.nf'

// Logging pipeline information
log.info """\
\033[0;36m  ==========================================  \033[0m
\033[0;34m              Q C O N T R O L                 \033[0m
\033[0;36m  ==========================================  \033[0m

    reads:      ${params.reads}
    outdir:     ${params.outdir}
    """
    .stripIndent(true)

// Define help
if ( params.help ) {
    help = """main.nf: This repository contains a Nextflow pipeline for analyzing 
            |Next-Generation Sequencing (NGS) data using octopus 
            |
            |Required arguments:
            |   --reads         Location of the input file file.
            |                   [default: ${params.reads}]
            |   --outdir        Location of the output file file.
            |                   [default: ${params.outdir}]
            |
            |Optional arguments:
            |   -profile        <docker/singularity>
            |   --reports        Generate pipeline reports
            |
""".stripMargin()
    // Print the help with the stripped margin and exit
    println(help)
    exit(0)
}

// Make the results directory if it needs
def result_dir = new File("${params.outdir}")
result_dir.mkdirs()

// Make the pipeline reports directory if it needs
if ( params.reports ) {
    def pipeline_report_dir = new File("${params.outdir}/pipeline_info/")
    pipeline_report_dir.mkdirs()
}


// Define the input channel for FASTQ files, if provided
input_fastqs = params.reads ? Channel.fromFilePairs("${params.reads}/*[rR]{1,2}*.*{fastq,fq}*", checkIfExists: true) : null


// Define the workflow
workflow {
    QCONTROL(input_fastqs)
    TRIM(input_fastqs)
    REPORT(QCONTROL.out.zip.collect(), TRIM.out.json.collect()) 
}

// Log pipeline execution summary on completion
workflow.onComplete {
    log.info """\033[0;32m\
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete.format('yyyy-MM-dd_HH-mm-ss')}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        \033[0m"""
        .stripIndent()
        
    log.info ( workflow.success ? "\nDone" : "\nOops" )
}