#!/bin/bash

#Loading requires shell libraries
scriptDir=$(dirname ${BASH_SOURCE[0]})
cd $scriptDir/../
excludeLibs="! -name .git \
! -name init \
! -name . \
"

availableLibs=($(find -maxdepth 1 -type d $excludeLibs|sed 's#./##g'))

echo -e "Available libraries:\n\t \033[32m${availableLibs[@]}\033[0m"
echo -e "example:  You can execute $0 color: keep color library."

allLibs=($(find -maxdepth 1 ! -name .|sed 's#./##g'))
keepLibs=($@)


isRequire(){
    lib=$1
    for kl in ${allLibs[@]}
    do
        [ $kl == "init" ] && continue
        source $kl/$kl.sh > /dev/null 2>&1
        [ $? -ne 0 ] && continue
        if require $lib;then
            return 0
        fi
    done
    return 1
}
# return 0 or 1.
##0 == keep lib directory
##1 == remove lib directory
isKeep(){
    local l=$1
    local isKeep=false
    for kl in $keepLibs
    do
        [ $kl == $l ] && return 0
    done
    return 1
}

for lib in ${allLibs[@]}
do
    if ! $(isKeep $lib) && ! $(isRequire $lib);then
        echo rm -rf $lib
    fi
done