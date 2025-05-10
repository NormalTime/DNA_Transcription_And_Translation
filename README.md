# DNA Transcription and Translation Summary Report 

## Abstract
 <!-- a one paragraph "abstract" type overview of what your project consists of.  This should be written for a general programmer audience, something that anyone who has taken up to 211 could understand. Style-wise it should be a scientific abstract. -->
 This project consisted of making two scripts to print the results of DNA transcription and translation. The goal was to have DNA strands as input in the form of a .fasta file and output their transcribed and translated forms. In order to perform transcription, DNA changes it's T's to U's in order to create mRNA. In order to perform translation, three letters are taken as input and changed into a respective protein codon. Every set of three letters available corresponds to a specific protein, which acts as the instructions to make up proteins in chromosomes. 

## Reflection
 <!-- a one paragraph reflection that summarizes challenges faced and what you learned doing your project, the audience here is your instructors -->
At first the project was pretty easy; It served as good practice for getting the hang of making bash scripts. When starting this project, I didn't actually think to use .fasta files and my test cases were very small. Not considering working with .fasta files and using very small test cases made the project very easy overall. By the time I had finished the project initially, I had then reformed much of each script around parsing .fasta files to output the DNA strand's origin as well as it's transcription and translation outputs. Figuring out how to parse the .fasta files wasn't that hard but was mostly time-consuming and fairly annoying. Overall, this project allowed me to learn more about the basics of programming in bash. From making loops to program design, as well as getting to see the impact of very large input sizes of files on runtime. An important note about the translation script is that unless you're analyzing the entirety of a DNA strand from start to end, it's most definitely useless. I realized halfway through this project that because in a lot of files, you don't necessarily start with the absolute beginning of the DNA strand. Thus, if you use the translation script with an incomplete strand, there's a 66% chance you get the completely wrong output.

## Artifacts 
- Transcription Script
```
#!/bin/bash
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
> transcription_output.txt
echo "Now processing strand(s), please wait a moment"
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
```

- Translation Script
```
#!/bin/bash
[ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
num=0
codon=''
echo "Now processing strands, please wait a moment"
> translation_output.txt
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
#cat translation_output.txt
echo "done!"
```


<!-- links to other materials required for assessing the project.  This can be a public facing web resource, a private repository, or a shared file on URI google Drive.  -->

# How to use the tool
## File input
- Any .fasta file can work with this tool, I used covid samples of DNA from 2020 while testing this project
- I'd show output here but it would get very messy very quickly due to how large DNA can be
- you can use the tools via command line with ./translation.sh example.fasta or ./transcription.sh example.fasta
- the file names are not important for running the tools, you can name them whatever you like (applies to both script and .fasta file)
- If a file is not already made prior to execution, a text file called "translation_output.txt" or "transcription_output.txt" will be made during the runtime of the script
    - All it does is contain the respective output of the script thats run
    - It's much neater than immedietely printing the results
- The translation script specifically can take in either DNA or mRNA strands as input
- The transcription script must take in a DNA strand, otherwise you'll get an unchanged strand as output

## Results
- With the transcription tool, the input DNA strand will be transcribed into its mRNA version. In simpler terms, all of the T's in the original DNA strand will be turned to U's.
- With the transcription tool, the input DNA or mRNA strand will be translated into protein codons.
  - Every three letters in DNA and mRNA correspond to a specific protein to help make up a bigger structure
  - This tool is to be ideally used with a complete DNA strand, from start to finish
  - Using this tool in the middle of a DNA strand will most definitely fetch incorrect results. This is because starting translation with, for example, the 2nd letter in a DNA strand, will throw off the rest of the protein codons being translated.
