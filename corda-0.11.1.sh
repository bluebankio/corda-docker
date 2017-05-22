#!/bin/bash

# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.

export CORDA_HOST="${CORDA_HOST-localhost}"
export CORDA_PORT_P2P="${CORDA_PORT-10002}"
export CORDA_PORT_RPC="${CORDA_PORT-10003}"
export CORDA_LEGAL_NAME="${CORDA_LEGAL_NAME-Corda Test Node}"
export CORDA_ORG="${CORDA_ORG-CordaTest}"
export CORDA_ORG_UNIT="${CORDA_ORG_UNIT-CordaTest}"
export CORDA_COUNTRY="${CORDA_COUNTRY}-UK"
export CORDA_CITY="${CORDA_CITY-London}"
export CORDA_EMAIL="${CORDA_EMAIL-admin@corda.test}"

cd /opt/corda

cat > node.conf << EOF
basedir : "/opt/corda"
p2pAddress : "$CORDA_HOST:$CORDA_PORT_P2P"
rpcAddress : "$CORDA_HOST:$CORDA_PORT_RPC"
h2port : 11000
nearestCity : "$CORDA_CITY"
myLegalName : "CN=$CORDA_LEGAL_NAME,O=$CORDA_ORG,OU=$CORDA_ORG_UNIT,L=$CORDA_CITY,C=$CORDA_COUNTRY"
emailAddress : "$CORDA_EMAIL"
keyStorePassword : "cordacadevpass"
trustStorePassword : "trustpass"
extraAdvertisedServiceIds: [ "" ]
useHTTPS : false
devMode : true
rpcUsers=[
	{
		user=corda
		password=not_blockchain
		permissions=[
			StartFlow.net.corda.flows.CashIssueFlow,
			StartFlow.net.corda.flows.CashExitFlow,
			StartFlow.net.corda.flows.CashPaymentFlow
		]
	}
]
EOF

exec java -jar /opt/corda/corda.jar >>/opt/corda/logs/output.log 2>&1
