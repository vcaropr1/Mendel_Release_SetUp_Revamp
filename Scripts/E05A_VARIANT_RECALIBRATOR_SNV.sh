#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4
HAPMAP_VCF=$5
OMNI_VCF=$6
ONEKG_SNPS_VCF=$7
DBSNP_138_VCF=$8

CORE_PATH=$9
PROJECT=${10}
PREFIX=${11}

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T VariantRecalibrator'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --input:VCF '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.vcf'
CMD=$CMD' -resource:hapmap,known=false,training=true,truth=true,prior=15.0 '$HAPMAP_VCF
CMD=$CMD' -resource:omni,known=false,training=true,truth=true,prior=12.0 '$OMNI_VCF
CMD=$CMD' -resource:1000G,known=false,training=true,truth=false,prior=10.0 '$ONEKG_SNPS_VCF
CMD=$CMD' -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 '$DBSNP_138_VCF
CMD=$CMD' -mode SNP'
CMD=$CMD' -an QD'
CMD=$CMD' -an SOR'
CMD=$CMD' -an MQRankSum'
CMD=$CMD' -an ReadPosRankSum'
CMD=$CMD' -an FS'
CMD=$CMD' -tranche 100.0'
CMD=$CMD' -tranche 99.9'
CMD=$CMD' -tranche 99.8'
CMD=$CMD' -tranche 99.7'
CMD=$CMD' -tranche 99.6'
CMD=$CMD' -tranche 99.5'
CMD=$CMD' -tranche 99.4'
CMD=$CMD' -tranche 99.3'
CMD=$CMD' -tranche 99.2'
CMD=$CMD' -tranche 99.1'
CMD=$CMD' -tranche 99.0'
CMD=$CMD' -tranche 98.0'
CMD=$CMD' -tranche 97.0'
CMD=$CMD' -tranche 96.0'
CMD=$CMD' -tranche 95.0'
CMD=$CMD' -tranche 90.0'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K $KEY'
CMD=$CMD' -recalFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.SNV.recal'
CMD=$CMD' -tranchesFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.SNV.tranches'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -rscriptFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.SNV.R'


echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash


# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T VariantRecalibrator \
# -R $REF_GENOME \
# --input:VCF $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.vcf" \
# -resource:hapmap,known=false,training=true,truth=true,prior=15.0 $HAPMAP_VCF \
# -resource:omni,known=false,training=true,truth=true,prior=12.0 $OMNI_VCF \
# -resource:1000G,known=false,training=true,truth=false,prior=10.0 $ONEKG_SNPS_VCF \
# -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 $DBSNP_138_VCF \
# -mode SNP \
# -an QD \
# -an SOR \
# -an MQRankSum \
# -an ReadPosRankSum \
# -an FS \
# -tranche 100.0 \
# -tranche 99.9 \
# -tranche 99.8 \
# -tranche 99.7 \
# -tranche 99.6 \
# -tranche 99.5 \
# -tranche 99.4 \
# -tranche 99.3 \
# -tranche 99.2 \
# -tranche 99.1 \
# -tranche 99.0 \
# -tranche 98.0 \
# -tranche 97.0 \
# -tranche 96.0 \
# -tranche 95.0 \
# -tranche 90.0 \
# -recalFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.recal" \
# -tranchesFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.tranches" \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -rscriptFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.R"
