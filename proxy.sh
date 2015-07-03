#!/bin/bash

USER=$1
PASSWORD=$2
PROXY_URL=$3
PROXY_PORT=$4
ERROR_MISSING_PARAMETERS="Missing parameters.\nTo set user and password type sudo ./proxy.sh [user] [password]\nTo set proxy and port type ./proxy.sh [user] [password] [proxy] [port]"
ERROR_TOO_MANY_PARAMETERS="Too many parameters.\nTo set user and password type sudo ./proxy.sh [user] [password]\nTo set proxy and port type ./proxy.sh [user] [password] [proxy] [port]"

if [ $# -eq 0 ]
then
	echo -e $ERROR_MISSING_PARAMETERS
	exit 1
elif [[ -z "$1" || -z "$2" ]]
then
	echo -e $ERROR_MISSING_PARAMETERS
	exit 1
elif [[ -z "$3" ]]
then
	PROXY_URL='default_proxy'
	PROXY_PORT='8080'
elif [[ -z "$4" ]]
then
	PROXY_PORT='8080'
elif [ "$#" -gt 4 ]
then
	echo -e $ERROR_TOO_MANY_PARAMETERS
	exit 1
fi

if [[ ! -f /etc/apt/apt.conf.d/95proxies ]] || [[ ! -r /etc/apt/apt.conf.d/95proxies ]]
then
    echo " "> /etc/apt/apt.conf.d/95proxies
    echo "File created for apt proxy >> /etc/apt/apt.conf.d/95proxies"
fi

sed -i 's/^.*/Acquire::http:Proxy "http:\/\/'"$USER"':'"$PASSWORD"'@'"$PROXY_URL"':'"$PROXY_PORT"'\/;''"/g' /etc/apt/apt.conf.d/95proxies

sed -i 's/http_proxy=.*/http_proxy=http:\/\/'"$USER"':'"$PASSWORD"'@'"$PROXY_URL"':'"$PROXY_PORT"'\//g' /etc/environment
sed -i 's/https_proxy=.*/https_proxy=http:\/\/'"$USER"':'"$PASSWORD"'@'"$PROXY_URL"':'"$PROXY_PORT"'\//g' /etc/environment
sed -i 's/ftp_proxy=.*/ftp_proxy=http:\/\/'"$USER"':'"$PASSWORD"'@'"$PROXY_URL"':'"$PROXY_PORT"'\//g' /etc/environment
sed -i 's/HTTP_PROXY=.*/HTTP_PROXY=http:\/\/'"$USER"':'"$PASSWORD"'@'"$PROXY_URL"':'"$PROXY_PORT"'\//g' /etc/environment
sed -i 's/HTTPS_PROXY=.*/HTTPS_PROXY=http:\/\/'"$USER"':'"$PASSWORD"'@'"$PROXY_URL"':'"$PROXY_PORT"'\//g' /etc/environment
sed -i 's/FTP_PROXY=.*/FTP_PROXY=http:\/\/'"$USER"':'"$PASSWORD"'@'"$PROXY_URL"':'"$PROXY_PORT"'\//g' /etc/environment
