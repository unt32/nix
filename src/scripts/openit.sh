#!/bin/sh

t=$(file "$1")
echo "$t" 

case "$t" in
  *text*) 	st bat --paging=always "$1";;
  *) 		xdg-open "$1";;
esac
