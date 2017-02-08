#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -M vcaropr1@jhmi.edu
#$ -m beas
#$ -p -1000
JAVA_1_7=$1
shift
GATK_DIR=$1
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
BED_FILE=$1
shift

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T GenotypeGVCFs'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --annotateNDA'
while [ $# -gt 0 ]
do
  CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$1'.'$BED_FILE'.genome.vcf'
  shift
done
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -XL 11:78516315-78516329'
CMD=$CMD' -XL 19:5787188-5787257'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -L '$CORE_PATH'/'$PROJECT'/TEMP/BED_FILE_SPLIT/'$BED_FILE'.bed'
CMD=$CMD' -K '$KEY
CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE'.temp.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T GenotypeGVCFs \
# -R $REF_GENOME \
# --annotateNDA \
# --variant $CORE_PATH/$PROJECT/GVCF/AGGREGATE/$PREFIX"."$CHROMOSOME".genome.vcf" \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -XL 11:78516315-78516329 \
# -XL 19:5787188-5787257 \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/TEMP/$PREFIX"."$CHROMOSOME".temp.vcf"

