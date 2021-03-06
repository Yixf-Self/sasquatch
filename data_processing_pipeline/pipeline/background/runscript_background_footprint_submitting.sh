#!/bin/bash

#############################################################################################
##                                                                                          ##
## Sasquatch, Sequence based predicting of DNase I footprinting potential.                  ##
## Copyright (C) 2016 Genome Biology and Computational Biology Research Group, WIMM, Oxford ##
##                                                                                          ##
## Data preprocessing, background: backbone for submitting footprinting and profile calc    ##
##                                                                                          ##
##############################################################################################

#SCRIPT DIRs
PIPE_DIR=/t1-data1/WTSA_Dev/rschwess/Sasquatch_offline/Sasquatch/data_processing_pipeline/pipeline/tissue_v2
SCRIPT_DIR=/t1-data1/WTSA_Dev/rschwess/Sasquatch_offline/Sasquatch/data_processing_pipeline/scripts	

#TAG
IDTAG="hg18_human_h_ery_1"
#OUTPUT
OUTPUT_DIR=/t1-data1/WTSA_Dev/rschwess/database_assembly/idx_correct_assembly/background/${IDTAG}

#specify if DNaseI or ATAC data ("dnase" or "atac")
DATA_TYPE="dnase"
#type of sequencing ["singleend" / "pairedend"] 
SEQ_TYPE="singleend"	

#specify bam file / naked digest
BAM_FILE=/t1-data1/WTSA_Dev/msuciu/Background_controls/DNase_Backgrounds/human/pipe/version17_unfiltered/Human_JH_DNase_Background_v17_unFiltered/hg18/Background_DNaseI_Human_Merge_hg18.bam

#genome Build
BUILD='hg18'
#chose chr sizes and ploidy regions to filter
if [ "${BUILD}" == "hg19" ]
then
	REF_GENOME="/databank/igenomes/Homo_sapiens/UCSC/hg19/Sequence/WholeGenomeFasta/genome.fa"
	BIGWIG_CHRSIZES='/t1-data1/user/config/bigwig/hg19_sizes.txt'
	#ploidy regions to filter
	PLOIDY_REGIONS='/t1-data1/WTSA_Dev/rschwess/database_assembly/region_exclude/hg19/wgEncodeDukeMapabilityRegionsExcludable.bed'
	
elif [ "${BUILD}" == "hg18" ]   
then
	REF_GENOME="/databank/raw/hg18_full/hg18_full.fa"
	BIGWIG_CHRSIZES='/t1-data1/user/config/bigwig/hg18_sizes.txt'
	#ploidy regions to filter
	PLOIDY_REGIONS='/t1-data1/WTSA_Dev/rschwess/database_assembly/region_exclude/hg18/wgEncodeDukeMapabilityRegionsExcludable.bed'
fi

####################
# START PROCESSING #
####################

echo "starting at ..."
date

mkdir -p ${OUTPUT_DIR}

cd ${OUTPUT_DIR}

### -----------------
### Submit Footprints
### -----------------

fpid=`qsub -N fp_${IDTAG} -v OUTPUT_DIR=${OUTPUT_DIR},DATA_TYPE=${DATA_TYPE},BAM_FILE=${BAM_FILE},SCRIPT_DIR=${SCRIPT_DIR},BIGWIG_CHRSIZES=${BIGWIG_CHRSIZES},SEQ_TYPE=${SEQ_TYPE},IDTAG=${IDTAG} ${PIPE_DIR}/runscript_tissue_v2_footprinting.sh | perl -ne '$_=~/\s+(\d+)\s+/; print $1;'`

echo "Footprinting Job $fpid submitted"


