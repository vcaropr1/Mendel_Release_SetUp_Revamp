#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR=$2
REF_GENOME=$3
KEY=$4

CORE_PATH=$5
PROJECT=$6
PREFIX=$7
CHROMOSOME=$8

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T VariantAnnotator \
-R $REF_GENOME \
--variant $CORE_PATH/$PROJECT/TEMP/$PREFIX"."$CHROMOSOME".temp.vcf" \
--dbsnp $DBSNP \
-L $CORE_PATH/$PROJECT/TEMP/$PREFIX"."$CHROMOSOME".temp.vcf" \
-A GCContent \
-A VariantType \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX"."$CHROMOSOME".normal.vcf"
