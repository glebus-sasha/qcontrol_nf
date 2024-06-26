# qcontrol_nf
Nextflow-based pipeline for quality control and trimming

This pipeline is prepared for:
- [glebus-sasha/deepvariant_nf](https://github.com/glebus-sasha/deepvariant_nf)
- [glebus-sasha/octopus_nf](https://github.com/glebus-sasha/octopus_nf)

```mermaid
%%{init: {'theme':'base'}}%%
flowchart TB
    subgraph " "
    v0["reads"]
    end
    v1([QCONTROL])
    subgraph " "
    v9["html"]
    v10["fastq"]
    end
    v3([TRIM])
    v8([REPORT])
    v6(( ))
    v7(( ))
    v0 --> v1
    v0 --> v3
    v1 --> v6
    v3 --> v7
    v3 --> v10
    v6 --> v8
    v7 --> v8
    v8 --> v9
```

## Description

The pipeline is implemented in Nextflow and includes several stages for NGS data analysis:

1. **QCONTROL:** Quality control using FastQC.
2. **TRIM:** Data preprocessing using Fastp.
3. **REPORT:** Compiling report using MultiQC.

## Usage

### Quick Start

To quickly run the pipeline, use the following command:

```bash
nextflow run glebus-sasha/qcontrol_nf \
-profile <docker/singularity> \
--reads <path-to-reads> \
--outdir results
```

### Requirements

- Nextflow (https://www.nextflow.io/docs/latest/install.html)
- Docker (https://docs.docker.com/engine/install/) or
- Singularity (https://github.com/sylabs/singularity/blob/main/INSTALL.md)

### Running the Pipeline

1. Install all the necessary dependencies such as Nextflow, Singularity.
3. Clone this repository: `git clone https://github.com/glebus-sasha/qcontrol_nf.git`
4. Navigate to the pipeline directory: `cd qcontrol_nf`
5. Edit the `nextflow.config` file to set the required parameters, if necessary.
6. Run the pipeline, setting the required parameters, for example:

```bash
nextflow run main.nf
```

## License

This project is licensed under the [MIT License](LICENSE).
