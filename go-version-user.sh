#!/bin/bash

##Detects whether GOLANG needs updating, and uses 
##This script is intended to be run as <User>
##It just informs you that an update is needed
##Use go-version-root.sh to actually update as root.

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
    echo "GOLANG needs updating... Please log into ROOT" 
 fi
else
 echo "GO NOT FOUND! Oh dear!"
fi

exit 0

          
