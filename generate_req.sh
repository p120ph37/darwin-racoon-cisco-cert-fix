#!/bin/bash

ORG="Your Organization"
COUNTRY=US
STATE=CA
GROUP=YOURGROUP
EMAIL="yourname@youremail.com"

CONTINUE=./combine_cert.sh
if [[ $1 ]]; then
    echo "Preparing to generate a private key and"
    echo "certificate request with the following information:"
    echo "=================================================="
    echo "Organization: ${ORG}"
    echo "Country: ${COUNTRY}"
    echo "State: ${STATE}"
    echo "Group: ${GROUP}"
    echo "Email: ${EMAIL}"
    echo "User: $1"
    echo "--------------------------------------------------"
    echo "If this is incorrect, press ^C now and correct it."
    echo "The country, state, and group are defined at the top of $0"
    echo "=================================================="
    read -p "Press enter to continue"
    openssl req -new -config vpnreq.config -out $1-req.pem -keyout $1-key.pem \
      -subj "/C=${COUNTRY}/ST=${STATE}/O=${ORG}/OU=${GROUP}/CN=$1/emailAddress=${EMAIL}"
    cat $1-req.pem
    echo "=================================================="
    echo "Copy and paste the above request into the"
    echo " certificate request form for your VPN or forward"
    echo " it to your network administrator"
    echo "--------------------------------------------------"
    echo "After your request has been approved, retrive the"
    echo " \"certificate chain\" in \"ASCII\" format from"
    echo " your certificate request server or your network"
    echo " administrator and save it to this directory as"
    echo " \"certnew.p7b\""
    echo "=================================================="
    read -p "Press enter to continue\n(or to continue later, type: \"${CONTINUE} $0\" )"
    $CONTINUE $1
else
    echo "Syntax: $0 username"
fi
