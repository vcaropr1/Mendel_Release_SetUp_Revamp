# ---qsub parameter settings---
# --these can be overrode at qsub invocation--

# tell sge to execute in bash
#$ -S /bin/bash

# tell sge to submit any of these queue when available
#$ -q prod.q,rnd.q,test.q

# tell sge that you are in the users current working directory
#$ -cwd

# tell sge to export the users environment variables
#$ -V

# tell sge to submit at this priority setting
#$ -p -50

# tell sge to output both stderr and stdout to the same file
#$ -j y

# export all variables, useful to find out what compute node the program was executed on
# redirecting stderr/stdout to file as a log.

JAVA_1_7=$1
GATK_DIR=$2
REF_GENOME=$3
KEY=$4

CORE_PATH=$5
PROJECT=$6
GVCF_LIST=$7
PREFIX=$8
BED_FILE=$9

mkdir -p $CORE_PATH/$PROJECT/GVCF/AGGREGATE
mkdir -p $CORE_PATH/$PROJECT/MULTI_SAMPLE
mkdir -p $CORE_PATH/$PROJECT/TEMP


CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T CombineGVCFs'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --variant '$GVCF_LIST
CMD=$CMD' -L '$CORE_PATH'/'$PROJECT'/TEMP/BED_FILE_SPLIT/'$BED_FILE'.bed'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K '$KEY
CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/GVCF/AGGREGATE/'$PREFIX'.'$BED_FILE'.genome.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T CombineGVCFs \
# -R $REF_GENOME \
# --variant $GVCF_LIST \
# -L $CHROMOSOME \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/GVCF/AGGREGATE/$PREFIX"."$CHROMOSOME".genome.vcf"

