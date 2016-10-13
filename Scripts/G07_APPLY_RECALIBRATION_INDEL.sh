#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

source /u01/home/khetrick/bashrc_change_R

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4

CORE_PATH=$6
PROJECT=$7
PREFIX=$8

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T ApplyRecalibration'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --input:VCF '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.SNV.VQSR.vcf'
CMD=$CMD' --ts_filter_level 99.9'
CMD=$CMD' -recalFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.INDEL.recal'
CMD=$CMD' -tranchesFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.INDEL.tranches'
CMD=$CMD' -mode INDEL'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.SNP.INDEL.VQSR.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T ApplyRecalibration \
# -R $REF_GENOME \
# --input:VCF $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.vcf" \
# --ts_filter_level 99.9 \
# -recalFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.recal" \
# -tranchesFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.tranches" \
# -mode INDEL \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.vcf"
