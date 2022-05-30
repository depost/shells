#!/bin/bash

require(){
    local r=$1
    case $r in
    *)
        return 1
    ;;
    esac
}

declare -A frontColorMap
frontColorMap["white"]=37
frontColorMap["red"]=31
frontColorMap["green"]=32
frontColorMap["yellow"]=33
frontColorMap["blue"]=34
frontColorMap["purple"]=35
frontColorMap["light blue"]=36
frontColorMap["none"]=38

# front colors
# color green green
color(){
    local c=""
    local msg=""
    case $# in
    0)
        echo -e "\033[33mWARN: FILE: $0, FUNC: $FUNCNAME(), LINE: $LINENO, requires at least 1 parameters!\033[0m"
        return 0
        ;;
    1)
        c=$1
        msg=$c
        ;;
    *)
        b=$1
        shift 1
        msg=$@
        ;;
    esac

    local defaultC=none

    if ! expr 1 + ${frontColorMap[$c]} > /dev/null 2>&1;then
        b=$defaultC
    fi

    echo -e "\033[${frontColorMap[$c]}m$msg\033[0m"
}

# colorf color 'format_strings' msg
# colorf red '%d\n' 10
colorf(){
    local c=$1
    shift 1
    echo $1
    local formatStr=$1
    shift 1
    local msg=$@

    printf "\033[${frontColorMap[$c]}m$formatStr\033[0m" $msg
}

# background colors
# background red "background color"
background(){
    # bColors=($(seq 41 48))
    local b=""
    local msg=""
    declare -A bMap
    #红色背景-41
    bMap["red"]=41
    #绿色背景-42
    bMap["green"]=42
    #黄色背景-43
    bMap["yellow"]=43
    #蓝色背景-44
    bMap=["blue"]=44
    #紫色背景-45
    bMap=["purple"]=45
    #浅蓝背景-46
    bMap=["light blue"]=46
    #白色背景-47
    bMap=["white"]=47
    #无-48
    bMap=["none"]=48

    case $# in
    0)
        color yellow "WARN: FILE: $0, FUNC: $FUNCNAME(), LINE: $LINENO, requires at least 1 parameters!"
        return 0
        ;;
    1)
        b=$1
        msg=$b
        ;;
    *)
        b=$1
        shift 1
        msg=$@
        ;;
    esac

    local defaultB=none

    # echo bmap: ${bMap[$b]}
    if ! expr 1 + ${bMap[$b]} > /dev/null 2>&1;then
        b=$defaultB
    fi
    echo -e "\033[${bMap[$b]}m$msg\033[0m"
}
