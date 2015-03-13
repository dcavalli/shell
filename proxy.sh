#!/bin/bash

user=$1
password=$2
proxy_URL=$3
proxy_port=$4

if [[ -z "$1" || -z "$2" ]]
then
	echo "Missing parameters."
elif [[ -z "$3" ]]
then
	proxy_URL='usproxy.es.oneadp.com'
	proxy_port='8080'
elif [[ -z "$4" ]]
then
	proxy_port='8080'
elif [ "$#" -gt 4 ]
then
	echo "Too many parameters."
fi

sed -i 's/^.*/Acquire::http:proxy "http:\/\/'"$user"':'"$password"'@'"$proxy_URL"':'"$proxy_port"'\/"/g' /etc/apt/apt.conf

sed -i 's/http_proxy=.*/http_proxy=http:\/\/'"$user"':'"$password"'@'"$proxy_URL"':'"$proxy_port"'\//g' /etc/environment
sed -i 's/https_proxy=.*/https_proxy=http:\/\/'"$user"':'"$password"'@'"$proxy_URL"':'"$proxy_port"'\//g' /etc/environment
sed -i 's/ftp_proxy=.*/ftp_proxy=http:\/\/'"$user"':'"$password"'@'"$proxy_URL"':'"$proxy_port"'\//g' /etc/environment
sed -i 's/HTTP_PROXY=.*/HTTP_PROXY=http:\/\/'"$user"':'"$password"'@'"$proxy_URL"':'"$proxy_port"'\//g' /etc/environment
sed -i 's/HTTPS_PROXY=.*/HTTPS_PROXY=http:\/\/'"$user"':'"$password"'@'"$proxy_URL"':'"$proxy_port"'\//g' /etc/environment
sed -i 's/FTP_PROXY=.*/FTP_PROXY=http:\/\/'"$user"':'"$password"'@'"$proxy_URL"':'"$proxy_port"'\//g' /etc/environment