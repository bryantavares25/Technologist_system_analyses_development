# # # Check if Kraken 2 databases are installed. If not, install them.
kraken2_path=$(conda env list | awk '$1 == "RGAP_kraken2" {nome = $NF} END {print nome}') # Finds the path to the Kraken 2 conda enviroment folder
dbs=(k2_standard_16gb_20241228) # List of the Kraken DBs that will be included from https://benlangmead.github.io/aws-indexes/k2

# for each db in list
for db_name in "${dbs[@]}"; do
    if [ ! -d ${kraken2_path}/kraken_dbs/${db_name} ]; then # check if db_name is installed
        echo -e "The $db_name database will be installed. This may take some time\n"
        # wget [link to db] -P [destiny folder]
        wget https://genome-idx.s3.amazonaws.com/kraken/${db_name}.tar.gz -P ${kraken2_path}/kraken_dbs/ # download db
        mkdir ${kraken2_path}/kraken_dbs/${db_name}
        tar -xvf ${kraken2_path}/kraken_dbs/${db_name}.tar.gz -C ${kraken2_path}/kraken_dbs/${db_name}/ #unzip db
        echo $db_name have been installed!
    else
        echo -e "Kraken 2 is already installed! \n"
    fi
    eval $(echo $db_name)=$(echo ${kraken2_path}'/kraken_dbs/'${db_name}) # creates a variable with name $[db name] containin the path to
done                                                                      # the [db name] folder, that can be used as an alias