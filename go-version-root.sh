#!/bin/bash

##Detects whether GOLANG needs updating, and uses 
## https://github.com/udhos/update-golang.git
## to do the heavy lifting!
## I found Udhos's version detection too verbose
##This script is intended to be run as ROOT
##

##go.dev/dl/$(curl https://go.dev/dl/?mode=json | jq -r '.[0].version').$os-$arch.$ext
latest_golang=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version')
go_path="$(which go)"
ret="$?"
if [[ "$ret" ]]; then
 echo "GOLANG found here: $go_path"
 current_golang=$(go version)
 #String manipulation to extract just the Version Info
 current_golang="${current_golang#go version }"
 current_golang="${current_golang% linux/amd64}"
 if [[ ${current_golang} == "${latest_golang}" ]]; then
    echo "GOLANG is the latest version." 
 else
    echo "GOLANG needs updating... Using Update script...."
    "$HOME/scripts/update-golang/update-golang.sh"
 fi
else
 echo "GOLANG NOT FOUND! Oh dear!"
fi

exit 0

          
