#!/bin/bash

CORE_PATH="/isilon/sequencing/Seq_Proj/"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.3-0"
REF_GENOME="/isilon/sequencing/GATK_resource_bundle/1.5/b37/human_g1k_v37_decoy.fasta"
JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
KEY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_2/lee.watkins_jhmi.edu.key"

PROJECT=$1
PREFIX=$2

START_COMBINE_VARIANTS=`date '+%s'`

$JAVA_1_7/java -jar /isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.1-1/GenomeAnalysisTK.jar \
-T CombineVariants \
-R $REF_GENOME \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".1.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".2.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".3.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".4.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".5.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".6.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".7.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".8.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".9.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".10.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".11.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".12.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".13.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".14.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".15.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".16.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".17.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".18.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".19.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".20.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".21.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".22.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".X.normal.vcf" \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".Y.normal.vcf" \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.vcf"

END_COMBINE_VARIANTS=`date '+%s'`

START_SELECT_SNPS=`date '+%s'`

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-selectType SNP \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.vcf" \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.SNV.vcf"

END_SELECT_SNPS=`date '+%s'`

START_SELECT_INDELS=`date '+%s'`

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-selectType INDEL \
-selectType MNP \
-selectType MIXED \
-selectType SYMBOLIC \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.vcf" \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.INDEL.vcf"

END_SELECT_INDELS=`date '+%s'`

START_VR_SNPS=`date '+%s'`

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T VariantRecalibrator \
-R $REF_GENOME \
--input:VCF $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.SNV.vcf" \
-resource:hapmap,known=false,training=true,truth=true,prior=15.0 /isilon/sequencing/GATK_resource_bundle/2.5/b37/hapmap_3.3.b37.vcf \
-resource:omni,known=false,training=true,truth=true,prior=12.0 /isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_omni2.5.b37.vcf \
-resource:1000G,known=false,training=true,truth=false,prior=10.0 /isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_phase1.snps.high_confidence.b37.vcf \
-resource:dbsnp,known=true,training=false,truth=false,prior=2.0 /isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.vcf \
-mode SNP \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-an QD \
-an SOR \
-an MQRankSum \
-an ReadPosRankSum \
-an FS \
-tranche 100.0 \
-tranche 99.9 \
-tranche 99.8 \
-tranche 99.7 \
-tranche 99.6 \
-tranche 99.5 \
-tranche 99.4 \
-tranche 99.3 \
-tranche 99.2 \
-tranche 99.1 \
-tranche 99.0 \
-tranche 98.0 \
-tranche 97.0 \
-tranche 96.0 \
-tranche 95.0 \
-tranche 90.0 \
-recalFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.recal" \
-tranchesFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.tranches" \
-rscriptFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.R"

END_VR_SNPS=`date '+%s'`

START_VR_INDELS=`date '+%s'`

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T VariantRecalibrator \
# -R $REF_GENOME \
# --input:VCF $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.INDEL.vcf" \
# -resource:mills,known=true,training=true,truth=true,prior=12.0 /isilon/sequencing/GATK_resource_bundle/2.2/b37/Mills_and_1000G_gold_standard.indels.b37.vcf \
# --maxGaussians 4 \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -an MQRankSum \
# -an FS \
# -an SOR \
# -an ReadPosRankSum \
# -an QD \
# -mode INDEL \
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
# -recalFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.recal" \
# -tranchesFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.tranches" \
# -rscriptFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.R"
#
END_VR_INDELS=`date '+%s'`

START_AR_SNPS=`date '+%s'`

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T ApplyRecalibration \
# -R $REF_GENOME \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# --input:VCF $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.SNV.vcf" \
# --ts_filter_level 99.9 \
# -recalFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.recal" \
# -tranchesFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.tranches" \
# -mode SNP \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.vcf"

END_AR_SNPS=`date '+%s'`

START_AR_INDELS=`date '+%s'`

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T ApplyRecalibration \
# -R $REF_GENOME \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# --input:VCF $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.INDEL.vcf" \
# --ts_filter_level 99.9 \
# -recalFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.recal" \
# -tranchesFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.tranches" \
# -mode INDEL \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.vcf"
#
END_AR_INDELS=`date '+%s'`

# Break out where AC<=10 for BIALLELIC INDELs

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.vcf" \
# -select 'AC < 11' \
# --restrictAllelesTo BIALLELIC \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.RARE.BIALLELIC.vcf"

# Annotate rare INDEL VCF file with SampleList

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T VariantAnnotator \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.RARE.BIALLELIC.vcf" \
# -L $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.RARE.BIALLELIC.vcf" \
# -A SampleList \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.RARE.BIALLELIC.ANNOTATED.vcf"

# Break out where AC>10 for BIALLELIC INDELs

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

# Break out MULTI-ALLELIC INDELS.

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.vcf" \
# --restrictAllelesTo MULTIALLELIC \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.VQSR.MULTIALLELIC.vcf"

# Break out where AC<=10 for BIALLELIC SNVs

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.vcf" \
# -select 'AC < 11' \
# --restrictAllelesTo BIALLELIC \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.RARE.BIALLELIC.vcf"

# Annotate rare SNV VCF file with SampleList

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T VariantAnnotator \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.RARE.BIALLELIC.vcf" \
# -L $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.RARE.BIALLELIC.vcf" \
# -A SampleList \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.RARE.BIALLELIC.ANNOTATED.vcf"

# Break out where AC>10 for BIALLELIC SNVs

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

# Break out MULTI-ALLELIC SNVS.

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.vcf" \
# --restrictAllelesTo MULTIALLELIC \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNV.VQSR.MULTIALLELIC.vcf"

# COMBINE THE SIX FILES TOGETHER

START_COMBINE_FINAL=`date '+%s'`

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

END_COMBINE_FINAL=`date '+%s'`

START_BGZIP_FINAL=`date '+%s'`

# bgzip-0.2.6 -c $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.vcf" >| $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.vcf.gz"
#
# END_BGZIP_FINAL=`date '+%s'`
#
# START_TABIX_FINAL=`date '+%s'`
#
# tabix-0.2.6 -p vcf -f $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.vcf.gz"
#
END_TABIX_FINAL=`date '+%s'`

echo $PREFIX",COMBINE_VARIANTS,"$START_COMBINE_VARIANTS","$END_COMBINE_VARIANTS >> joint.calling.times.csv
echo $PREFIX",SELECT_SNPS,"$START_SELECT_SNPS","$END_SELECT_SNPS >> joint.calling.times.csv
echo $PREFIX",SELECT_INDELS,"$START_SELECT_INDELS","$END_SELECT_INDELS >> joint.calling.times.csv

echo $PREFIX",VariantRecalibrator_SNPS,"$START_VR_SNPS","$END_VR_SNPS >> joint.calling.times.csv
echo $PREFIX",VariantRecalibrator_INDELS,"$START_VR_INDELS","$END_VR_INDELS >> joint.calling.times.csv

echo $PREFIX",ApplyRecalibration_SNPS,"$START_AR_SNPS","$END_AR_SNPS >> joint.calling.times.csv
echo $PREFIX",ApplyRecalibration_INDELS,"$START_AR_INDELS","$END_AR_INDELS >> joint.calling.times.csv

echo $PREFIX",COMBINE_FINAL,"$START_COMBINE_FINAL","$END_COMBINE_FINAL >> joint.calling.times.csv
echo $PREFIX",BGZIP_FINAL,"$START_BGZIP_FINAL","$END_BGZIP_FINAL >> joint.calling.times.csv
echo $PREFIX",SELECT_TABIX_FINAL,"$START_TABIX_FINAL","$END_TABIX_FINAL >> joint.calling.times.csv
