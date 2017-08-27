#!/bin/zsh

read "?Enter Docs Id from Google Drive: " docId

[ "$docId" ] || (echo "Id is empty, exiting" && exit)

mkdir -p ./tmp/$docId

cd ./tmp/$docId

filename=`gdrive info $docId | grep "Name: " | cut -d' ' -f2-`

gdrive export --force $docId

pdftotext "$filename.pdf"

sed 's/\xe2\x80\x8b//g' "$filename.txt" | tr '\r\n' ' ' | tr -s ' ' > ready_file.txt

rm -f ../../findings.txt
touch ../../findings.txt

echo "# write-good" >> ../../findings.txt
write-good ready_file.txt >> ../../findings.txt

echo "-----------------------------------------------------\n" >> ../../findings.txt

echo "# gender" >> ../../findings.txt
egrep --color -n -i ".{0,10}( his | her | she | he ).{0,10}" ready_file.txt >> ../../findings.txt

echo "-----------------------------------------------------\n" >> ../../findings.txt

echo "# proselint" >> ../../findings.txt
proselint ready_file.txt >> ../../findings.txt

echo "-----------------------------------------------------\n" >> ../../findings.txt

echo "# languagetool" >> ../../findings.txt
languagetool ready_file.txt >> ../../findings.txt
