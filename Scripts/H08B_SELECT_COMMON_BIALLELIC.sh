#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4

CORE_PATH=$6
PROJECT=$7
PREFIX=$8

## VCF --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.vcf"

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.vcf" \
-select 'AC > 10' \
--restrictAllelesTo BIALLELIC \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.COMMON.BIALLELIC.vcf"

# COMBINE THESE STEPS
# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.vcf" \
# -select 'AC > 10' \
# --restrictAllelesTo BIALLELIC \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.COMMON.BIALLELIC.vcf"
#
#
# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.vcf" \
# -select 'AC > 10' \
# --restrictAllelesTo BIALLELIC \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.COMMON.BIALLELIC.vcf"