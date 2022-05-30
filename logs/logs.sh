#!/bin/bash
# require color library

# require log library.
require(){
    local r=$1
    case $r in
    colors)
        return 0
    ;;
    *)
        return 1
    ;;
    esac
}