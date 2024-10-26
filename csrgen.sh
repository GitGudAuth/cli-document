#!/bin/bash    
    echo -n "Enter domain name: "
    read domain
    DIR="$HOME/SSL"
    if [ ! -d "$DIR" ]; then
	    mkdir -pv "$DIR"
	    echo "Directory $DIR created."
	    ls "$DIR"
	    echo ""
    fi
    
    cd $HOME/SSL 
    country=VN
    state=HCM
    locality=HCM
    organization=$domain
    organizationunit=IT
    openssl req -newkey rsa:2048 -nodes -keyout "$domain".key -out "$domain".csr -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationunit/CN=$domain"

    echo "Generating csr and private key complete !"
    echo 
    echo "---------------------------"
    echo "-----Below is your CSR-----"
    echo "---------------------------"
    echo
    cat $HOME/SSL/$domain.csr
    echo
    echo "---------------------------"
    echo "-----Below is your Key-----"
    echo "---------------------------"
    echo
    cat $HOME/SSL/$domain.key
