#!/bin/sh
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Use: tagmusicas.sh \"directory\" \"author\""
  exit 1
fi

for arquivo in "$1"/*; do
  if [ -f "$arquivo" ]; then
    echo "Processando: $arquivo"
    id3v2 --delete-all "$arquivo"
    id3v2 -a "$2" "$arquivo"
  else
    echo "No files found."
  fi
done

echo "Done!"
