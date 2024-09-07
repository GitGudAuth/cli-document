#!/bin/bash
sslgen() {
    echo -n "Enter domain name: "
    read domain

    # Subject
    commonname=$domain
    country=VN
    state=HCM
    locality=HCM
    organization=$domain
    organizationalunit=IT

    if [ ! -d "$HOME/SSL" ]; then
        mkdir -p "$HOME/SSL"
    fi
    
    cd $HOME/SSL
    openssl req -new  -newkey rsa:2048 -nodes -keyout "$domain".key -out "$domain".csr -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname"
    echo "---------------------------"
    echo "-----Below is your CSR-----"
    echo "---------------------------"
    echo
    cat "$domain".csr
    
    echo
    echo "---------------------------"
    echo "-----Below is your Key-----"
    echo "---------------------------"
    echo
    cat "$domain".key
    
    cd ~
    ls -l $HOME/SSL
    echo "Generating csr and private key complete !"
}
switchroot()
{    
    if [ "$(id -u)" != 0  ]
    then
        echo "Switching to root..."
        sleep 2
        sudo su
    else
        echo "You are root!"
        sleep 2
    fi
    }
updatepc() {
    sudo apt update
    echo -n "Do you to upgrade ? (y/n): "
    read updpc
    if [[ "$updpc" =~ [yY] ]]
    then
        echo "Upgrading now ..."
        sudo apt upgrade -y
    else
        echo "Canceled"
        sleep 2
    fi
}

diskspace() {
    echo "1. Display disk space."
    df -lTh
}
wholog() {
    echo "2. Display logged on users."
    who
}
memous() {
    echo "3. Display memory usage."
    free
}
run_program() {
    echo "Run program $1"
    $1
}
uninstall_program() {
    echo "Removing program $1"
    sudo apt remove -y $1
}
install_program() {
    echo "Installing program $1"
    sudo apt install -y $1
}
procheck() {
    read -p "Enter program name to check: " checkprog
    if command -v "$checkprog" &> /dev/null; then
        echo "$checkprog is installed."
        read -p "Do you want to (r)un or (u)ninstall $checkprog? (r/u): " CHOICE
        echo
        if [[ "$CHOICE" =~ [Rr] ]]
        then
            run_program $checkprog
        elif [[ "$CHOICE" =~ [Uu] ]]
        then
            uninstall_program $checkprog
        else
            echo "Invalid choice."
        fi
    else
        echo "$checkprog is not installed"
        read -p "Do you want to install $checkprog? (y/n): " CHOICE
        if [[ "$CHOICE" =~ [yY] ]]
        then
            install_program $checkprog
        else
            echo "Canceled"
        fi
    fi
}
exitmenu() {
    read -p "Are you sure to exit System Admin Menu (y/n) " ans
    if [[ $ans =~ [yY] ]]
    then
        echo Goodbye...
        sleep 2
        clear
        exit
    else
        echo "Return to main menu"
        sleep 2
    fi
}
rebo() {
    echo "Current time : $(date)"
    read -p "Enter reboot time : (minutes)" time
    sudo shutdown -r $time
    echo "Reboot in $time minutes"
}
poff() {
    read -p "Are you sure you want to poweroff this machine ? (y/n) " pof
    if [[ "$pof" =~ [yY] ]]
    then
        sudo poweroff
    else
        echo "Canceled"
    fi
}
while true
do
    clear
    cat<<EOF
        System Admin Menu.
        -------------------------------------------------
        1. Display disk space.
        2. Display logged on users.
        3. Display memory usage.
        4. Checking program.
        5. Reboot system schedule.
        6. Poweroff system.
        7. Update and Upgrade.
        8. Switching to root.
        9. CSR and Private key gen.
        0. Exit program.
        -------------------------------------------------
        Enter option:
EOF
        read CHOSEN
        case "$CHOSEN" in
            "1")
                clear
                diskspace
                read -p "Press any key to continue..."
            ;;
            "2")
                clear
                wholog
                read -p "Press any key to continue..."
            ;;
            "3")
                clear
                memous
                read -p "Press any key to continue..."
            ;;
            "4")
                clear
                procheck
                read -p "Press any key to continue..."
            ;;
            "5")
                clear
                rebo
                read -p "Press any key to continue..."
            ;;
            "6")
                clear
                poff
                read -p "Press any key to continue..."
            ;;
            "7")
                clear
                updatepc
                read -p "Press any key to continue..."
            ;;
            "8")
                clear
                switchroot
                read -p "Press any key to continue..."
            ;;
            "9")
                clear
                sslgen
                read -p "Press any key to continue..."
            ;;
            "0")
                clear
                exitmenu
            ;;
            *)
                clear
                echo "Invalid choice"
                read -p "Press any key to continue..."
            ;;
        esac
done
