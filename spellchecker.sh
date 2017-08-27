#!/bin/zsh

read "?Enter Docs id" docId

mkdir -p /tmp/$docId

/tmp/$docId

filename=`gdrive info $docId | grep "Name: " | cut -d' ' -f2-`

gdrive export $docId

pdftotext "$filename.pdf"

sed 's/\xe2\x80\x8b//g' "$filename.txt" | tr '\r\n' ' ' > ready_file.txt

languagetool ready_file.txt
