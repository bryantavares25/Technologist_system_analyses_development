#!/bin/bash

dir=$(pwd)

# Verificar a existência do conda
base_path=$(conda env list | awk '$1 == "base" {nome = $NF} END {print nome}')
if [ ! -d ${base_path}/ ]; then
    echo " Conda não está instalado. Então Conda será instalado. "
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    chmod +x ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm ~/miniconda3/miniconda.sh
    source ~/miniconda3/bin/activate
    conda init --all
else
    echo "Conda já está instalado."
fi

# Com ambiente conda
dir_name="$dir/ANALISES/scripts_acessorios/pipeline_ambientacao/"
for filename in ${dir_name}/*.yml; do
    name="$( echo $filename | rev | cut -d'/' -f1 | rev | cut -d'_' -f2-3 | cut -d'.' -f1 )" # get .yml files names
    envs="$(conda env list | awk '$1 == "'$name'" {env = $1} END {print env}')" # get name of the conda enviroment list (if it exists)
    if [ "$name" == "$envs" ]; then # tests if enviroment exists
        echo -e " - - - - - $name enviroment already exists! - - - "
    else
        echo -e " - - - - - Creating $name enviroment - - - "
        conda env create -y -f $filename # create required enviroment
    fi
done

#Instalar kraken
#echo "Instalando Kraken e baixando banco de dados"
#chmod +x ./ANALISES/scripts_acessorios/pipeline_ambientacao/install_kraken2_db.sh
#./ANALISES/scripts_acessorios/pipeline_ambientacao/install_kraken2_db.sh

#Instalar interproscan
#echo "Instalando Interproscan e baixando banco de dados"
#chmod +x ./ANALISES/scripts_acessorios/pipeline_ambientacao/install_interproscan.sh
#./ANALISES/scripts_acessorios/pipeline_ambientacao/install_interproscan.sh

# Instalar DB Browser for sqlite
snap install sqlitebrowser

# END