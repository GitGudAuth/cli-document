#!/bin/bash

echo "Script use to check SSL files"
echo -n "Enter your domain: "
read domain
# Exit menu function
exitmenu() {
    read -p "Are you sure to exit System Admin Menu (y/n) " ans
    if [[ $ans =~ [yY] ]]
    then
        echo Goodbye...
        sleep 1
        clear
        exit
    else
        echo "Return to main menu"
        sleep 2
    fi
}
while true
do
    clear
    cat<<EOF
        System Admin Menu.
        -------------------------------------------------
        1. Check CSR
        2. Check Key
        0.  Exit program.
        -------------------------------------------------
EOF
        echo -n "Enter option: "
        read CHOSEN
        case "$CHOSEN" in
            "1")
                openssl req -text -noout -in /home/*/SSL/"$domain".csr
                echo "---------------------------------"
                echo "===========CSR Content==========="
                echo "---------------------------------"
                cat /home/*/SSL/"$domain".csr
                read -p "Press any key to continue... "
            ;;
            "2")
                echo "---------------------------------"
                echo "===========KEY Content==========="
                echo "---------------------------------"
                openssl rsa -in /home/*/SSL/"$domain".key -check
                read -p "Press any key to continue... "
            ;;
            "0")
                exitmenu
            ;;
            *)
                echo "Invalid choice"
                read -p "Press any key to continue... "
            ;;
        esac
done
