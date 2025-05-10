#!/bin/bash
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
> transcription_output.txt
echo "Now processing strand(s), please wait a moment"
# Output the header of each strand when its found
# Then transcribe the strand
while IFS= read -r line; do
  if [[ "$line" == ">"* ]]; then
     echo "Found header: $line"
     echo -e "\n$line" >> transcription_output.txt
  else
  for (( i=0; i<${#line}; i++ )); do
  char="${line:i:1}"
  if [ "$char" = "T" ]; then
     echo -n "U" >> transcription_output.txt
  elif [ "$char" = "t" ]; then
     echo -n "U" >> transcription_output.txt
  else
     echo -n "$char" >> transcription_output.txt
  fi
  done
fi
done < "$input"
echo "Done!"
