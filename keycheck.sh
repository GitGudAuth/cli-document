#!/bin/bash
#
echo -n "Enter domain name: "
read domain
cd $HOME/SSL

# Check if both the CSR and Key files exist
if [[ ! -f "$domain.key" || ! -f "$domain.csr" ]]; then
    echo "Either $domain.key or $domain.csr does not exist in $HOME/SSL."
    exit 1
fi

# Check csr and key modulus
csr_modulus=$(openssl req -noout -modulus -in "$domain.csr" | openssl md5)
key_modulus=$(openssl rsa -noout -modulus -in "$domain.key" | openssl md5)

echo "CSR Modulus is: $csr_modulus"
echo "Key Modulus is: $key_modulus"

if [ "$csr_modulus" == "$key_modulus" ]; then
    echo "It's a match!"
else
    echo "It's not a match."
fi 
