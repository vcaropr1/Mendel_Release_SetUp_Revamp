#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -5

set

PROJECT=$1
REF_GENOME=$2
DBSNP=$3
GVCF_LIST=$4
CHROMOSOME=$5
PREFIX=$6

JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
CORE_PATH="/isilon/sequencing/Seq_Proj/"
BWA_DIR="/isilon/sequencing/Kurt/Programs/BWA/bwa-0.7.8/"
PICARD_DIR="/isilon/sequencing/Kurt/Programs/Picard/picard-tools-1.109"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.3-0"
GATK_DIR_NIGHTLY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-nightly-2015-01-15-g92376d3"
VERIFY_DIR="/isilon/sequencing/Kurt/Programs/VerifyBamID/verifyBamID_20120620/bin/"
BED_DIR=$CORE_PATH"/BED/"
GENE_LIST="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/RefSeqGene.GRCh37.Ready.txt"
VERIFY_VCF="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/Omni25_genotypes_1525_samples_v2.b37.PASS.ALL.sites.vcf"
EXON_BED="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/UCSC_hg19_CodingOnly_083013_MERGED_noContigs_noCHR.bed"
SAMTOOLS_DIR="/isilon/sequencing/Kurt/Programs/samtools/samtools-0.1.18/"
TABIX_DIR="/isilon/sequencing/Kurt/Programs/TABIX/tabix-0.2.6/"
KEY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_2/lee.watkins_jhmi.edu.key"

mkdir -p $CORE_PATH/$PROJECT/GVCF/AGGREGATE
mkdir -p $CORE_PATH/$PROJECT/MULTI_SAMPLE


## -----COMBINE GVCF-----

# Aggregate GVCF

# START_COMBINE_GVCF=`date '+%s'`

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T CombineGVCFs \
-R $REF_GENOME \
--variant $GVCF_LIST \
-L $CHROMOSOME \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/GVCF/AGGREGATE/$PREFIX"."$CHROMOSOME".genome.vcf"

END_COMBINE_GVCF=`date '+%s'`

START_GENOTYPE_GVCF=`date '+%s'`

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R $REF_GENOME \
--annotateNDA \
--variant $CORE_PATH/$PROJECT/GVCF/AGGREGATE/$PREFIX"."$CHROMOSOME".genome.vcf" \
--disable_auto_index_creation_and_locking_when_reading_rods \
-XL 11:78516315-78516329 \
-XL 19:5787188-5787257 \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/TEMP/$PREFIX"."$CHROMOSOME".temp.vcf"

END_GENOTYPE_GVCF=`date '+%s'`

START_VARIANTANNOTATOR=`date '+%s'`

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

END_VARIANTANNOTATOR=`date '+%s'`

echo $PREFIX"_"$CHROMOSOME",COMBINE_GVCF,"$START_COMBINE_GVCF","$END_COMBINE_GVCF >> joint.calling.times.csv
echo $PREFIX"_"$CHROMOSOME",GENOTYPE_GVCF,"$START_GENOTYPE_GVCF","$END_GENOTYPE_GVCF >> joint.calling.times.csv
echo $PREFIX"_"$CHROMOSOME",ANNOTATE_VCF,"$START_VARIANTANNOTATOR","$END_VARIANTANNOTATOR >> joint.calling.times.csv
