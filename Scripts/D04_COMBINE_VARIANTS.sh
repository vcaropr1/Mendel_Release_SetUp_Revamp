#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
shift
GATK_3_1_1_DIR=$1
shift
REF_GENOME=$1
shift
KEY=$1
shift
CORE_PATH=$1
shift
PROJECT=$1
shift
PREFIX=$1
shift

START_COMBINE_VARIANTS=`date '+%s'`

CMD=$JAVA_1_7'/java'
CMD=$CMD' -jar '$GATK_3_1_1_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T CombineVariants'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K '$KEY
for VCF in $(ls $CORE_PATH/$PROJECT/TEMP/AGGREGATE/$PREFIX'.SPLITTED_BED_FILE'*.vcf)
do
  CMD=$CMD' --variant '$VCF
done
CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.vcf'

# CMD=$JAVA_1_7'/java'
# CMD=$CMD' -jar '$GATK_3_1_1_DIR'/GenomeAnalysisTK.jar'
# CMD=$CMD' -T CombineVariants'
# CMD=$CMD' -R '$REF_GENOME
# CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
# CMD=$CMD' -et NO_ET'
# CMD=$CMD' -K '$KEY
# while [ $# -gt 0 ]
# do
#   CMD=$CMD' --variant '$1
#   shift
# done
# CMD=$CMD' -out '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# JAVA_1_7=$1
# GATK_3_1_1_DIR=$2
# REF_GENOME=$3
# KEY=$4
# CORE_PATH=$5
# PROJECT=$6
# PREFIX=$7
# 
# CMD=$JAVA_1_7'/java'
# CMD=$CMD' -jar '$GATK_3_1_1_DIR'/GenomeAnalysisTK.jar'
# CMD=$CMD' -T CombineVariants'
# CMD=$CMD' -R '$REF_GENOME
# CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
# CMD=$CMD' -et NO_ET'
# CMD=$CMD' -K '$KEY
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.1.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.2.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.3.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.4.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.5.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.6.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.7.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.8.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.9.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.10.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.11.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.12.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.13.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.14.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.15.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.16.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.17.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.18.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.19.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.20.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.21.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.22.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.X.normal.vcf'
# CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.Y.normal.vcf'
# CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.vcf'
# 
# echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
# echo >> $CORE_PATH/$PROJECT/command_lines.txt
# echo $CMD | bash

# $JAVA_1_7/java -jar $GATK_3_1_1_DIR/GenomeAnalysisTK.jar \
# -T CombineVariants \
# -R $REF_GENOME \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".1.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".2.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".3.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".4.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".5.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".6.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".7.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".8.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".9.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".10.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".11.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".12.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".13.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".14.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".15.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".16.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".17.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".18.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".19.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".20.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".21.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".22.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".X.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".Y.normal.vcf" \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.vcf"
