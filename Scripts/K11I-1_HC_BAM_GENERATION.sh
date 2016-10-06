#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V


JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4
DBSNP=$5

CORE_PATH=$6
OUT_PROJECT=$7
SM_TAG=$8

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R $REF_GENOME \
--input_file $CORE_PATH/$OUT_PROJECT/BAM/AGGREGATE/$SM_TAG".bam" \
--dbsnp $DBSNP \
-L $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG"_MS_OnBait.vcf.bed" \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-stand_call_conf 0 \
-stand_emit_conf 0 \
--bamOutput $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.bam" \
-pairHMM VECTOR_LOGLESS_CACHING \
-o $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf"
