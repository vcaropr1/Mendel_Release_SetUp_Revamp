#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_3_1_1_DIR=$2
KEY=$3
REF_GENOME=$4

CORE_PATH=$6
PROJECT=$7
PREFIX=$8

$JAVA_1_7/java -jar $GATK_3_1_1_DIR/GenomeAnalysisTK.jar \
-T CombineVariants \
-R $REF_GENOME \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.RARE.BIALLELIC.ANNOTATED.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.COMMON.BIALLELIC.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.COMMON.MULTIALLELIC.vcf" \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.vcf"


# $JAVA_1_7/java -jar /isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.1-1/GenomeAnalysisTK.jar \
# -T CombineVariants \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.RARE.BIALLELIC.ANNOTATED.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.COMMON.BIALLELIC.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.MULTIALLELIC.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.RARE.BIALLELIC.ANNOTATED.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.COMMON.BIALLELIC.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.MULTIALLELIC.vcf" \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.vcf"