                                                                                                                         30,0-1        All
#!/bin/bash
#SBATCH -N 1
#SBATCH -p short
#SBATCH -t 5:00:00
#SBATCH -n 32
#SBATCH --mem=15G

# load modules
module load singularity/3.10.3

# Define container image path
SINGULARITY_IMAGE="/work/seedpod/container/seedpod_rstudio.sif"

# Define input data paths
BAMLIST="/work/seedpod/rawdata/bam_lists/spal/bam_list"
REF="/work/seedpod/reference/updated.fasta"
OUTDIR="/work/seedpod/output/angsd_spal_SC"
ANGSD_OPTIONS="-GL 2 -doMajorMinor 1  -doGlf 2 -doMaf 2 -SNP_pval 1e-6 -minMapQ 30 -minQ 20 -minMaf 0.05 -minInd 300"

# Default to 32 CPUs if SLURM_CPUS_PER_TASK is not set
SLURM_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK:-32}

# Run container image with singularity

singularity exec -B "/work:/work" $SINGULARITY_IMAGE \
         angsd -b $BAMLIST -ref $REF -out $OUTDIR/redo${site}_list $ANGSD_OPTIONS -P ${SLURM_CPUS_PER_TASK}
