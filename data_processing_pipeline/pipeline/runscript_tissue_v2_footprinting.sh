#!usr/bin/bash

##############################################################################################
##                                                                                          ##
## Sasquatch, Sequence based predicting of DNase I footprinting potential.                  ##
## Copyright (C) 2016 Genome Biology and Computational Biology Research Group, WIMM, Oxford ##
##                                                                                          ##
## Data preprocessing: footprinting script				                    ##
##                                                                                          ##
##############################################################################################

#$ -cwd
#$ -q batchq
#$ -M rschwess
#$ -m eas
#$ -j y
#$ -o /t1-data1/WTSA_Dev/rschwess/clustereo

mkdir -p ${OUTPUT_DIR}/footprints	#make footprint directory
cd ${OUTPUT_DIR}/footprints

### TEST ECHO ###
echo "OUTPUT_DIR = ${OUTPUT_DIR}"
echo "BAM_FILE = ${BAM_FILE}"
echo "IDTAG = ${IDTAG}"
echo " ============================== "

date 

#check if dase or atac and choose appropriate Print_it_All ... file for footprinting wig generation
if [ "${DATA_TYPE}" == "DNase" ]
	then

		#create strand specific footprints
		samtools view ${BAM_FILE} | perl ${SCRIPT_DIR}/Print_It_All_combined.pl --build ${BIGWIG_CHRSIZES} --name ${IDTAG} --type ${SEQ_TYPE} -

	elif [ "${DATA_TYPE}" == "ATAC" ]
		then

		samtools view ${BAM_FILE} | perl ${SCRIPT_DIR}/Print_It_All_combined_atac.pl --build ${BIGWIG_CHRSIZES} --name ${IDTAG} --type ${SEQ_TYPE} -

	else
		echo "DNase or ATAC? DATA_TYPE not correctly specified!"
fi
		
echo "footprints done ..."
date
