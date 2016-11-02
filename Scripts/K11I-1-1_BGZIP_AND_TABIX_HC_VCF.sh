#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V

TABIX_DIR=$1

CORE_PATH=$2
OUT_PROJECT=$3
SM_TAG=$4


CMD1=$TABIX_DIR'/bgzip -c '$CORE_PATH'/'$OUT_PROJECT'/HC_BAM/'$SM_TAG'_MS_OnBait.HC.vcf'
CMD1=$CMD1' >| '$CORE_PATH'/'$OUT_PROJECT'/HC_BAM/'$SM_TAG'_MS_OnBait.HC.vcf.gz'

CMD2=$TABIX_DIR'/tabix -p vcf -f '$CORE_PATH'/'$OUT_PROJECT'/HC_BAM/'$SM_TAG'_MS_OnBait.HC.vcf.gz'

echo $CMD1 >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD1 | bash

echo $CMD2 >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD2 | bash

# $TABIX_DIR/bgzip -c $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf" \
# >| $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf.gz"

# $TABIX_DIR/tabix -f -p vcf $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf.gz"
