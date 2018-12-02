#!/bin/bash

killall 'Cisco AnyConnect Secure Mobility Client' 2>/dev/null
/opt/cisco/anyconnect/bin/vpn disconnect >/dev/null

code=`oathtool --totp -b $AUTH_CODE`

/opt/cisco/anyconnect/bin/vpn -s connect $VPN_URL << EOF | sed 's/Password: .*/Password: ********/g'
$USER_NAME
$PASSWORD
$VALIDATE_TYPE
$code
EOF

open -g '/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app'