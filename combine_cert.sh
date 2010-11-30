#!/bin/bash

if [[ $1 ]]; then
    openssl pkcs7 -print_certs -in certnew.p7b | openssl pkcs12 -export -inkey $1-key.pem -nomaciter -passout pass:$1 -out $1.p12
    echo "======================================================================"
    echo "Your certificate+key is now saved as: $1.p12 with a passphrase of \"$1\""
    echo "======================================================================"
else
    echo "Syntax: $0 username"
fi
