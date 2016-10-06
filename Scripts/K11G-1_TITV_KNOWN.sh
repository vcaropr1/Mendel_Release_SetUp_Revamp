#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V

SAMTOOLS_DIR=$1

CORE_PATH=$2
OUT_PROJECT=$3
SM_TAG=$4

$SAMTOOLS_DIR/bcftools/vcfutils.pl qstats $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.Known.TiTv.vcf" >| \
$CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV_MS/$SM_TAG"_Known_.titv.txt"
