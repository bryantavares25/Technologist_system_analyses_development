# # # # # NEED TO BE TESTED # # # # #
#
# Download interproscan
echo ' - - - Downloading INTERPROSCAN (This may took some time) - - - '
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.73-104.0/interproscan-5.73-104.0-64-bit.tar.gz -P ~/tmp_interproscan
#
# Test if any error ocurred in the download process
echo ' - - - Testing download integrity - - - '
wget https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.73-104.0/interproscan-5.73-104.0-64-bit.tar.gz.md5 -P ~/tmp_interproscan
md5sum -c ~/tmp_interproscan/interproscan-5.73-104.0-64-bit.tar.gz.md5
#
# Install INTERPROSCAN to all users
echo ' - - - Installing INTEPROSCAN in a shared folder (This will need SUDO permission!) - - - '
sudo tar -pxvzf ~/tmp_interproscan/interproscan-5.73-104.0-*-bit.tar.gz -C /usr/local/src/ # Unzip directly to shared folder
rm ~/tmp_interproscan -r # Exclude temporary folder where ziped interproscan were downloaded
# WARNING > Modification > cd /usr/local/src/interproscan-5.73-104.0/ > sudo python3 /usr/local/src/interproscan-5.73-104.0/setup.py -f interproscan.properties > cd
sudo python3 /usr/local/src/interproscan-5.73-104.0/setup.py -f /usr/local/src/interproscan-5.73-104.0/interproscan.properties # This command will press and index the hmm models to prepare them into a format used by hmmscan
sudo ln -s /usr/local/src/interproscan-5.73-104.0/interproscan.sh /usr/local/bin/interproscan # Create a symbolic link to make interproscan able to run by name
echo ' - - - INTERPROSCAN is now installed - - - '

######## ----> NEED TO INCLUDE A TEST TO CHECK IF ALL OCURRED AS EXPECTED
