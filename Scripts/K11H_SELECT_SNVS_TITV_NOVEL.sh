#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V


JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4
KNOWN_SNPS=$5

CORE_PATH=$6
OUT_PROJECT=$7
SM_TAG=$8
TITV_BED=$9

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-R $REF_GENOME \
-sn $SM_TAG \
-ef \
-env \
-L $TITV_BED \
--excludeFiltered \
--discordance $KNOWN_SNPS \
-selectType SNP \
--variant $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf" \
-o $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.Novel.TiTv.vcf"






