#!/bin/sh

if [[ $(file "$1") == *"text"* ]]; then
  st bat --paging=always "$1"
else
  xdg-open "$1"
fi

