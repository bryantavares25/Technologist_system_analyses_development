#!/bin/bash

# # # # # # # # # R E G E N E R A # # # # # # # # #

# < CABECALHO >
echo " ================================================ "
echo " ================ | B A C M A P | =============== "
echo " ================================================ "

# # # # # # # # # # # WALK 0 # # # # # # # # # # #

# < CONFIGURAÇÃO E INSTALAÇÃO >
echo " ===== | CONFIGURAÇÃO E INSTALAÇÃO | ===== "

# < diretorio parental >
dir=$(pwd)

# < instalação de ambientes conda>
echo " > Configuração de ambientes e programas - START <"
chmod +x "$dir/ANALISES/scripts_acessorios/pipeline_ambientacao/00_programas_e_ambientes.sh"
source $dir/ANALISES/scripts_acessorios/pipeline_ambientacao/00_programas_e_ambientes.sh
echo " > Configuração de ambientes e programas - END <"

# <ambiente base conda>
conda activate
#pip install Biopython
#pip install pandas
#conda install sqlite -c conda-forge -y
conda deactivate

# < Criação do banco de dados isoladosdb > 
echo " > Criação de Banco de Dados inicial (isoladosdb) - START < " 
conda activate
python3 "$dir/ANALISES/scripts_acessorios/pipeline_ambientacao/00_isoladosdb_criacao.py"
conda deactivate
echo " > Criação de Banco de Dados inicial (isoladosdb) - END < " 

# # # # # # # # # # # WALK 1 # # # # # # # # # # #

# < INICIALIZAÇÃO DE BANCO DE DADOS E DIRETÓRIOS >
echo " ===== | INICIALIZAÇÃO DE BANCO DE DADOS E DIRETÓRIOS | ===== "

# < Entrada de dados >
echo " > Lendo arquivo de dados e transerindo para inicio da análise - START < "
file_entrada="$dir/tabela_inicial.csv"
cp "$file_entrada" "$dir/ANALISES/tabela_inicial.csv"
echo " > Lendo arquivo de dados e transerindo para inicio da análise - END < "

# < Importação de isolados no isoladosdb >
echo " > Importação no Banco de Dados central (isoladosdb) - START < "
conda activate
python3 "$dir/ANALISES/scripts_acessorios/pipeline_inicializacao/01_isoladosdb_importacao.py"
conda deactivate
echo " > Importação no Banco de Dados inicial (isoladosdb) - END < "

# < Importação de sequencias no genomicasdb-isoladodb >
echo " > Importação no Banco de Dados genomicasdb (isoladodb) - START < "
conda activate
python3 "$dir/ANALISES/scripts_acessorios/pipeline_inicializacao/02_sequenciado_importacao.py"
conda deactivate
echo " > Importação no Banco de Dados genomicasdb (isoladodb) - END < "

# # # # # # # # # # # WALK 2 # # # # # # # # # # #

# < PROCESSAMENTO DE ANALISES GENOMICAS >
echo " ===== | PROCESSAMENTO DE ANALISES GENÔMICAS | ===== "

# < Entrada de dados >
seqid="$dir/ANALISES/tabela_inicial.csv"

chmod +x "$dir/ANALISES/scripts_acessorios/genomica_montagem/00_montagem.sh"
chmod +x "$dir/ANALISES/scripts_acessorios/genomica_anotacao/00_anotacao.sh"

temp_file="$dir/ANALISES/temp_file.csv"
cabecalho=$(head -n 1 "$dir/ANALISES/tabela_inicial.csv")

tail -n +2 "$seqid" | while IFS=, read -r col1 col2 col3 col4 col5 col6 col7 col8; do

    # Criação de referência: arquivo temporário 
    echo $cabecalho > $temp_file
    echo "$col1,$col2,$col3,$col4,$col5,$col6,$col7,$col8" >> "$temp_file"
    cat $temp_file

    # Montagem
    conda activate
    python3 "$dir/ANALISES/scripts_acessorios/genomica_montagem/00_montagem_diretorios.py"
    source $dir/ANALISES/scripts_acessorios/genomica_montagem/00_montagem.sh
    conda deactivate

    # Anotação
    # python3 "$dir/ANALISES/scripts_acessorios/genomica_anotacao/00_anotacao_diretorios.py"
    # source $dir/ANALISES/scripts_acessorios/genomica_anotacao/00_anotacao_diretorios.py

    #rm $temp_file
    echo " Finalização da linha "
done

# < Finalização de leitura do pipeline >
echo " Leitura de aquivo de entrada finalizada. "

# Rodapé
echo " ================ | Conclusão | ================ "
echo " =============== | B A C M A P | =============== "

# # # # # # # # # R E G E N E R A # # # # # # # # #

# # # # # # # # # # B. A. R. T. # # # # # # # # # #