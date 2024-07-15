#!/bin/bash
souredownload() {
    mkdir sourcesoft
    cd sourcesoft
    linkexpat=$(curl -s https://api.github.com/repos/libexpat/libexpat/releases/latest | grep -Eo 'https://github.com/libexpat/libexpat/releases/download/[^\"]*/expat-[^\"]*\.tar\.gz' | head -n 1)
    linkhttpd=$(curl -s https://httpd.apache.org/download.cgi | grep -Eo 'https://downloads.apache.org/httpd/httpd-[0-9.]+.tar.gz' | head -1)
    linkapr_util=$(curl -s https://apr.apache.org/download.cgi | grep -Eo "https://dlcdn.apache.org//apr/apr-util-[0-9.]+.tar.gz" | head -n 1)
    linkapr=$(curl -s https://apr.apache.org/download.cgi | grep -Eo "https://dlcdn.apache.org//apr/apr-[0-9.]+.tar.gz" | head -n 1)
    linkpcre2=$(curl -s https://api.github.com/repos/PCRE2Project/pcre2/releases/latest | grep -Eo 'https://github.com/PCRE2Project/pcre2/releases/download/pcre2-[0-9.]+/pcre2-[0-9.]+.tar.gz' | head -n 1)
    linkgcc=$(curl -s https://api.github.com/repos/gcc-mirror/gcc/tags | grep -Eo 'https://api.github.com/repos/gcc-mirror/gcc/tarball/refs/tags/releases/gcc-[0-9.]+' | head -n 1)

    yum groupinstall 'Development Tools'

    echo "Do you want to download all the dependencies ? (y/n): "
    read ans
    if [[ $ans =~ [yY] ]]; then
        wget $linkapr $linkapr_util $linkexpat $linkhttpd $linkpcre2 $linkgcc
    else
        echo "Canceled"
    fi
}

while true
do
    clear
    cat<<EOF
        LAMP & LEMP Automate
        --------------------------------------
        1. Download all the dependencies

        --------------------------------------
        Enter option:
EOF
    read chosen
    case $chosen in
        "1")
            clear
            souredownload
            read -p "Press any key to continue..."
        ;;
        *)
            read -p "Press any key to continue..."
        ;;
    esac