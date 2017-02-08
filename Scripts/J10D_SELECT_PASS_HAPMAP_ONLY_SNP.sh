#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V


JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4

CORE_PATH=$5
IN_PROJECT=$6
PREFIX=$7
MENDEL_SAMPLE_LIST=$8

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T SelectVariants'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K '$KEY
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' -env'
CMD=$CMD' -ef'
CMD=$CMD' -selectType SNP'
CMD=$CMD' --exclude_sample_file '$MENDEL_SAMPLE_LIST
CMD=$CMD' --variant '$CORE_PATH'/'$IN_PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.VQSR.vcf'
CMD=$CMD' -o '$CORE_PATH'/'$IN_PROJECT'/MULTI_SAMPLE/VARIANT_SUMMARY_STAT_VCF/'$PREFIX'.BEDsuperset.VQSR.SNP.HAPMAP.SAMPLES.ONLY.PASS.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

