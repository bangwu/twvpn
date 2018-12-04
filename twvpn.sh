#!/bin/bash

killall 'Cisco AnyConnect Secure Mobility Client' 2>/dev/null
/opt/cisco/anyconnect/bin/vpn disconnect >/dev/null

AUTH_CODE=$(security find-generic-password -a auth_code -s playground -w)
USER_NAME=$(security find-generic-password -a user_name -s playground -w)
VPN_URL=$(security find-generic-password -a vpn_url -s playground -w)
PASSWORD=$(security find-generic-password -a password -s playground -w)
VALIDATE_TYPE=$(security find-generic-password -a validate_type -s playground -w)
code=`oathtool --totp -b $AUTH_CODE`


/opt/cisco/anyconnect/bin/vpn -s connect $VPN_URL << EOF | sed 's/Password: .*/Password: ********/g'
$USER_NAME
$PASSWORD
$VALIDATE_TYPE
$code
EOF

open -g '/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app'