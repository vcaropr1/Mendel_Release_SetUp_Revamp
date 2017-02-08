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

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T SelectVariants'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K '$KEY
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' -ef'
CMD=$CMD' -env'
CMD=$CMD' -L '$TITV_BED
CMD=$CMD' --discordance '$KNOWN_SNPS
CMD=$CMD' -selectType SNP'
CMD=$CMD' --variant '$CORE_PATH'/'$OUT_PROJECT'/VCF/RELEASE/FILTERED_ON_BAIT/'$SM_TAG'_MS_OnBait.vcf'
CMD=$CMD' -o '$CORE_PATH'/'$OUT_PROJECT'/TEMP/'$SM_TAG'.Release.Novel.TiTv.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -R $REF_GENOME \
# -ef \
# -env \
# -L $TITV_BED \
# --excludeFiltered \
# --discordance $KNOWN_SNPS \
# -selectType SNP \
# --variant $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf" \
# -o $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.Novel.TiTv.vcf"

