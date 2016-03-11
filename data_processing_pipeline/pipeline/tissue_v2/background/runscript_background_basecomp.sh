#!usr/bin/bash

#$ -cwd
#$ -q batchq
#$ -M rschwess
#$ -m eas
#$ -e /t1-data1/WTSA_Dev/rschwess/clustereo
#$ -o /t1-data1/WTSA_Dev/rschwess/clustereo
#$ -N bc_iall_c22_hg19rp

chromosome=22

IDTAG="hg19_ploidy_removed"

SCRIPT_DIR=/t1-data1/WTSA_Dev/rschwess/Sasquatch_offline/Sasquatch/data_processing_pipeline/scripts

OUTPUT_DIR=/t1-data1/WTSA_Dev/rschwess/database_assembly/idx_correct_assembly/background/${IDTAG}/basecomp

BORDER_FILE_PLUS=/t1-data1/WTSA_Dev/rschwess/scripts/dnase_tissue_motif/workflow/pipeline/region_exclude_borders/borders_ploidy_removed_plus_chromosome${chromosome}.bed

echo "Starting ... "
mkdir -p ${OUTPUT_DIR} 
cd ${OUTPUT_DIR}

for i in 5 6 7
do
date 

perl ${SCRIPT_DIR}/count_kmers_naked_base_composition_v3_regionbased.pl /t1-data1/WTSA_Dev/rschwess/dnase_motif_tissue/kmers/All_Possible_Sequences_${i}.txt ${i} ${BORDER_FILE_PLUS} ${OUTPUT_DIR}/kmer_${i}_${IDTAG}_basecomp_plus_chromosome${chromosome}

echo "$i plus done"
date

done
