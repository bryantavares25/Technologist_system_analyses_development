# Trim adapters and low quality sequences, and compare quality of the imput and output data
#
# seqid: 
#   run fastqc
#   run trimmomatic
#   run fastqc

#####
direc=$(pwd)
adapters="$direc/ANALISES/scripts_acessorios/genomica_montagem/adapters.fa"
direc_temp_file_csv=$direc/ANALISES/temp_file.csv
isolado_code=$(awk -F',' 'NR==2 {print $6}' "$direc_temp_file_csv")
sequenciado_code=$(awk -F',' 'NR==2 {print $7}' "$direc_temp_file_csv")
dados_cami=$(awk -F',' 'NR==2 {print $8}' "$direc_temp_file_csv")
montado_cami=$(awk -F',' 'NR==2 {print $9}' "$direc_temp_file_csv")
montado_code=$(awk -F',' 'NR==2 {print $10}' "$direc_temp_file_csv")
isolado_cami=$dados_cami/SEQUENCIADO/$sequenciado_code

echo "Caminho Montado (variável): $montado_cami"
echo "Código Montado (variável): $montado_code"
#####

# STEP 1 - Sequence valuation
echo - - - STEP01 - - - sequence raw valuation
conda activate RGAP_fastqc # fastqc and multiqc
fastqc "${isolado_cami}/${sequenciado_code}_F.fastq.gz" "${isolado_cami}/${sequenciado_code}_R.fastq.gz" -o "${montado_cami}/01_seq_val/fastqc"
multiqc "${montado_cami}/01_seq_val/fastqc" -o "${montado_cami}/01_seq_val"  
conda deactivate

# STEP 2 - Sequence cleaning
echo - - - STEP02 - - - sequence cleaning
conda activate RGAP_trimmomatic # trimmomatic
ILLUMINACLIP_params="ILLUMINACLIP:$adapters:2:30:10:2:keepBothReads"
trim_parameters="MINLEN:50 HEADCROP:19 CROP:150"
input_files="${isolado_cami}/${sequenciado_code}_F.fastq.gz ${isolado_cami}/${sequenciado_code}_R.fastq.gz"
output_files="${montado_cami}/02_seq_cle/${montado_code}_Fp.fq.gz ${montado_cami}/02_seq_cle/${montado_code}_Fu.fq.gz ${montado_cami}/02_seq_cle/${montado_code}_Rp.fq.gz ${montado_cami}/02_seq_cle/${montado_code}_Ru.fq.gz"
trimmomatic PE -phred33 $input_files $output_files $ILLUMINACLIP_params $trim_parameters 
conda deactivate

# STEP 3 - Sequence cleaning valuation
echo - - - STEP03 - - - sequence cleaning valuation
conda activate RGAP_fastqc # fastqc and multiqc
fastqc "${montado_cami}/02_seq_cle/${montado_code}_Fp.fq.gz" "${montado_cami}/02_seq_cle/${montado_code}_Rp.fq.gz" -o "${montado_cami}/03_seq_val/fastqc"
multiqc "${montado_cami}/03_seq_val/fastqc" -o "${montado_cami}/03_seq_val"
conda deactivate

# STEP 4 - Genome sequence contigs assembly
echo - - - STEP04 - - - genome sequence contigs assembly
conda activate RGAP_megahit # megahit
megahit -1 "${montado_cami}/02_seq_cle/${montado_code}_Fp.fq.gz" -2 "${montado_cami}/02_seq_cle/${montado_code}_Rp.fq.gz" -o "${montado_cami}/04_seq_con/megahit/"
conda deactivate

# STEP 5 - Genome sequence contigs assembly valuation
echo - - - STEP05 - - - genome contigs quality
conda activate RGAP_quast # quast
quast "${montado_cami}/04_seq_con/megahit/final.contigs.fa" -o "${montado_cami}/05_val_con/"
cd "${montado_cami}/05_val_con"
busco -i "${montado_cami}/04_seq_con/megahit/final.contigs.fa" -m genome -o busco_output -l $direc/ANALISES/scripts_acessorios/genomica_montagem/bacteria_odb10 -f
cd
cd $direc # return to the project folder
conda deactivate

# STEP 6 - Genome sequence scaffold assembly
echo - - - STEP06 - - - genome sequence scaffold assembly 
conda activate RGAP_spades # spades
spades.py --only-assembler -1 "${isolado_cami}/${sequenciado_code}_F.fastq.gz" -2 "${isolado_cami}/${sequenciado_code}_R.fastq.gz" -o "${montado_cami}/06_seq_sca" --trusted-contigs "${montado_cami}/04_seq_con/megahit/final.contigs.fa" -m 10
seqkit seq -m 1000 "${montado_cami}/06_seq_sca/scaffolds.fasta" > "${montado_cami}/06_seq_sca/scaffolds_filtered.fasta"
conda deactivate

# STEP 7 - Genome sequence scaffold assembly valuation
echo - - - STEP07 - - - genome scaffold quality
conda activate RGAP_quast
quast "${montado_cami}/06_seq_sca/scaffolds_filtered.fasta" -o "${montado_cami}/07_val_sca"
cd "${montado_cami}/07_val_sca"
busco -i "${montado_cami}/06_seq_sca/scaffolds_filtered.fasta" -m genome -o busco_output -l $direc/ANALISES/scripts_acessorios/genomica_montagem/bacteria_odb10
cd
cd $direc # return to the project folder
conda deactivate

# END

# DRAFT - Used in some cases, but not in the current pipeline
# STEP 0
#echo - - - STEP00 - - - fastq adjust
#conda activate RGAP_fastqc # seqtk
#input_intercalado=/home/bryantavares/Documents/Genomes/SRR7601683.fastq
#output_forward_desintercalado=/home/bryantavares/Documents/Genomes/SRR7601683_F.fastq
#output_reverse_desintercalado=/home/bryantavares/Documents/Genomes/SRR7601683_R.fastq
#echo "Iniciando a desintercalação do arquivo: ${input_intercalado}"
#seqtk seq -1 "${input_intercalado}" | gzip > "${output_forward_desintercalado}.gz"
#seqtk seq -2 "${input_intercalado}" | gzip > "${output_reverse_desintercalado}.gz"
#echo "- **Leituras Forward:** ${output_forward_desintercalado}"
#echo "- **Leituras Reverse:** ${output_reverse_desintercalado}"
#conda deactivate

#
