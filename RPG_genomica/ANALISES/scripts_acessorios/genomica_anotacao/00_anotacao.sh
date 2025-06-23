# Perform scaffold structural and functional annotation, and taxonomy classification
#
# for each seqid: 
#	run prokka
#	run interproscan
#	run kraken2

# STEP 8.1 - Genome structural annotation
echo - - - STEP 08 - - - genome structutal annotation
conda activate RGAP_prokka # prokka
prokka /04_seq_con/megahit/final.contigs.fa -o /08_gen_ann
conda deactivate

# STEP 8.2 - Genome functional annotation
echo - - - STEP 09 - - - genome functional annotation
conda activate RGAP_interproscan
interproscan -i /08_gen_ann/PROKKA*.faa -f tsv -o /08_gen_ann/interproscan_output.tsv -appl Pfam,PROSITEPATTERNS,PROSITEPROFILES,ncbifam -goterms
conda deactivate

# STEP 9 - Taxonomy classification
echo - - - STEP 09 - - - genome taxonomy annotation
conda activate RGAP_kraken2 # kraken 2 # Usar de 16S
mkdir ${direc}${i}/09_tax_cla/
kraken2 --db $k2_standard_16gb_20241228 --report /09_tax_cla/kraken2_report.txt --output /09_tax_cla/kraken2_output.txt ${direc}${i}/04_seq_con/megahit/final.contigs.fa
conda deactivate

# END