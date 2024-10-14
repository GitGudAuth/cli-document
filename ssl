#!/bin/bash

##
# Script which lets you gather some basic information about your SSL certificate
##

##
# Colors
##
green=$(printf '\e[32m')
blue=$(printf '\e[34m')
clear=$(printf '\e[0m')
orange=$(printf '\e[33m')
red=$(printf '\e[31m')
cyan=$(printf '\e[36m')

##
# Color Functions
##
ColorGreen(){
        echo -ne $green$1$clear
}
ColorBlue(){
        echo -ne $blue$1$clear
}
ColorRed(){
        echo -ne $red$1$clear
}
ColorOrange(){
        echo -ne $orange$1$clear
}
ColorCyan(){
        echo -ne $cyan$1$clear
}
ColorClear(){
        echo -ne $clear
}
# Enable Color - ON/Clear 
ColorGreenON(){
        echo -ne $green
}
ColorBlueON(){
        echo -ne $blue
}
ColorRedON(){
        echo -ne $red
}
ColorOrangeON(){
        echo -ne $orange
}
ColorCyanON(){
        echo -ne $cyan
}

echo -ne "$(ColorRed '---------------------------------------------------------')\n" 
##
# Make sure that openssl is installed
##
if ! [ -x "$(command -v openssl)" ] ; then
        echo "The openssl command is required! Please install it and then try again"
        exit 1
fi

case $1 in
# Usage example
help)
        echo -ne "Usage:
$(ColorGreen './ssl domain.com')
"
        exit 1
;;
"")
        echo -ne "Usage:
$(ColorGreen './ssl domain.com')
"
        exit 1
;;
*)
	##
	# Check if the domain can be resolved
	##
	host -t A $1 > /dev/null
	if [ $? -eq 0 ]; then
		echo -e "$(ColorRed '#') $(ColorGreen 'Checking Domain/Hostname:')\n\t$1"
	else
		echo -e "Error: Could Not Resolve $(ColorGreen ${1}) Domain Name..."
		exit 1
	fi

	today=$(date +%F)
	expires=$(echo|openssl s_client -servername $1 -connect $1:443 2>/dev/null|openssl x509 -noout -dates|grep 'notAfter'|sed 's/notAfter=//')

	echo -e "$(ColorRed '#') $(ColorGreen 'Leaf Certificate Issued For:')"
	echo|openssl s_client -servername $1 -connect $1:443 2>/dev/null|openssl x509 -noout -subject|sed 's/subject=/Domain: /'
	echo "$(ColorRed '----')"

   echo -e "$(ColorRed '#') $(ColorGreen 'Leaf Certificate Expires In:')"

	# Detect the platform (similar to $OSTYPE)
	OS="`uname`"
	case $OS in
	  'Linux'|'FreeBSD'|'SunOS'|'AIX')
		echo $(( ( $(date -ud "$expires" +'%s') - $(date -ud "$today" +'%s') )/60/60/24 )) days
		;;
	  'Darwin') 
		OS='Mac'
		export LC_TIME="en_US"    
		echo "	$(( ( $(date -j -f "%b %d %T %Y %Z" "$expires" +'%s') - $(date -j -f "%F" "$today" +'%s') )/60/60/24 )) days"
		;;
	  *) 
		echo "Error: Can't Find DATE command for your OS version!"
		;;
	esac
	echo "$(ColorRed '----')"
	echo -e "$(ColorRed '#') $(ColorGreen 'Leaf Certificate Dates:')"
	echo|openssl s_client -servername $1 -connect $1:443 2>/dev/null|openssl x509 -noout -dates|\
	 sed 's/notAfter=/Expires On: /' | sed 's/notBefore=/Issued  On: /'
	echo "$(ColorRed '----')"

   echo -e "$(ColorRed '#') $(ColorGreen 'Leaf Certificate Issued by:')"
	echo|openssl s_client -servername $1 -connect $1:443 2>/dev/null|openssl x509 -noout -issuer|sed 's/issuer=/Issuer: /'
	echo "$(ColorRed '----')"

   echo -e "$(ColorRed '#') $(ColorGreen 'TLS supported:')"
	nmap -sV --script ssl-enum-ciphers -p 443 $1 | egrep -i 'tls.*:'
	echo "$(ColorRed '----')"
   
	echo -e "$(ColorRed '#') $(ColorGreen 'Leaf Certificate SANs:')"
	echo|openssl s_client -servername $1 -connect $1:443 2>/dev/null|openssl x509 -text |egrep "DNS:"|tr -d " \t"|tr , '\n'|sed  's/^/	/'
	echo "$(ColorRed '----')"

	echo -e "$(ColorRed '#') $(ColorGreen 'Certificate Chains:')"
	ColorOrangeON; timeout 2 openssl s_client -quiet -showcerts -servername $1 -connect $1:443;ColorClear 
	echo "$(ColorRed '----')"
   echo -e "$(ColorRed '#') $(ColorGreen 'Certificates Details:')"
	OLDIFS=$IFS; IFS=':' 
	certificates=$(echo|openssl s_client -servername $1 -showcerts -connect "$1:443" 2>&1| \
	sed -n '/-----BEGIN/,/-----END/p'|sed 's/^-----BEGIN/:-----BEGIN/'); 
	for certificate in ${certificates#:}; do ColorOrangeON
		for attr in subject serial fingerprint; do echo $certificate|openssl x509 -noout -$attr|tr -d ":"| tr '[:upper:]' '[:lower:]' ;done; echo ''
	done; IFS=$OLDIFS
	echo "$(ColorRed '----')"
esac

