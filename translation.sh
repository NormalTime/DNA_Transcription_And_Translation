#!/bin/bash
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
num=0
codon=''
echo "Now processing strands, please wait a moment"
> translation_output.txt
#Checks each line and looks for headers of new strand
while IFS= read -r line; do
  if [[ "$line" == ">"* ]]; then
     echo "Found header: $line"
     echo -e "\n$line" >> translation_output.txt
  else
     while IFS= read -r -n1 char; do
   #  echo "Current Codon: $codon"
  if [ "$char" = "T" ] || [ "$char" = "t" ]; then
     codon="${codon}U"
  else
     codon="${codon}${char}"
  fi
  ((num++))
  #If third letter is found, translate it into a protein codon
  if [ "$num" = "3" ]; then
     #find proper codon sequence
     if [ "$codon" = "AUG" ]; then
        echo -n "Met " >> translation_output.txt
     elif [ "$codon" = "UGA" ] || [ "$codon" = "UAA" ] || [ "$codon" = "UAG" ]; then
        echo -n "STOP " >> translation_output.txt
     elif [ "$codon" = "AUA" ] || [ "$codon" = "AUC" ] || [ "$codon" = "AUU" ]; then
        echo -n "Ile " >> translation_output.txt
     elif [ "$codon" = "ACA" ] || [ "$codon" = "ACG" ] || [ "$codon" = "ACC" ] || [ "$codon" = "ACU" ]; then
        echo -n "Thr " >> translation_output.txt
     elif [ "$codon" = "AGA" ] || [ "$codon" = "AGG" ]; then
        echo -n "Arg " >> translation_output.txt
     elif [ "$codon" = "AGC" ] || [ "$codon" = "AGU" ]; then
        echo -n "Ser " >> translation_output.txt
     elif [ "$codon" = "AAA" ] || [ "$codon" = "AAG" ]; then
        echo -n "Lys " >> translation_output.txt
     elif [ "$codon" = "AAC" ] || [ "$codon" = "AAU" ]; then
        echo -n "Asn " >> translation_output.txt
     #All the C's
     elif [ "$codon" = "CAA" ] || [ "$codon" = "CAG" ]; then
        echo -n "Gln " >> translation_output.txt
     elif [ "$codon" = "CAC" ] || [ "$codon" = "CAU" ]; then
        echo -n "His " >> translation_output.txt
     elif [ "$codon" = "CGA" ] || [ "$codon" = "CGG" ] || [ "$codon" = "CGC" ] || [ "$codon" = "CGU" ]; then
        echo -n "Arg " >> translation_output.txt
     elif [ "$codon" = "CCA" ] || [ "$codon" = "CCG" ] || [ "$codon" = "CCC" ] || [ "$codon" = "CCU" ]; then
        echo -n "Pro " >> translation_output.txt
     elif [ "$codon" = "CUA" ] || [ "$codon" = "CUG" ] || [ "$codon" = "CUC" ] || [ "$codon" = "CUU" ]; then
        echo -n "Leu " >> translation_output.txt
     #All the U's
     elif [ "$codon" = "UUU" ] || [ "$codon" = "UUC" ]; then
        echo -n "Phe " >> translation_output.txt
     elif [ "$codon" = "UUG" ] || [ "$codon" = "UUA" ]; then
        echo -n "Leu " >> translation_output.txt
     elif [ "$codon" = "UCU" ] || [ "$codon" = "UCC" ] || [ "$codon" = "UCG" ] || [ "$codon" = "UCA" ]; then
        echo -n "Ser " >> translation_output.txt
     elif [ "$codon" = "UGG" ]; then
        echo -n "Trp " >> translation_output.txt
     elif [ "$codon" = "UGU" ] || [ "$codon" = "UGC" ]; then
        echo -n "Cys " >> translation_output.txt
     elif [ "$codon" = "UAU" ] || [ "$codon" = "UAC" ]; then
        echo -n "Tyr " >> translation_output.txt
     #All the G's
     elif [ "$codon" = "GAA" ] || [ "$codon" = "GAG" ]; then
        echo -n "Glu " >> translation_output.txt
     elif [ "$codon" = "GAC" ] || [ "$codon" = "GAU" ]; then
        echo -n "Asp " >> translation_output.txt
     elif [ "$codon" = "GGA" ] || [ "$codon" = "GGG" ] || [ "$codon" = "GGC" ] || [ "$codon" = "GGU" ]; then
        echo -n "Gly " >> translation_output.txt
     elif [ "$codon" = "GCA" ] || [ "$codon" = "GCG" ] || [ "$codon" = "GCC" ] || [ "$codon" = "GCU" ]; then
        echo -n "Ala " >> translation_output.txt
     elif [ "$codon" = "GUA" ] || [ "$codon" = "GUG" ] || [ "$codon" = "GUC" ] || [ "$codon" = "GUU" ]; then
        echo -n "Val " >> translation_output.txt
     #break if stop codon is reached
     fi
     codon=""
     num=0
   fi
   done < <(echo "$line")
  fi
done < "$input"
#print output file
echo "done!"
