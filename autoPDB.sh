#!/bin/bash

#Software and Author information 
echo "autoPDB: Input uniprot.xml and your Entry list, I will catch all PDB chain of your porteins, and tell you all Entry without pdb structure."
echo "Author:Lin Wang"
echo "If you have some unexpected errors in running the script, please contact me. Email:wanglin3@shanghaitech.edu.cn"
echo ""

#Read uniprot.xml
if [ -f "uniprot.xml" ];then
	echo "Note: uniprot.xml has been found."
else
	echo "Error: Can't find uniprot.xml. Please check it."
	exit
fi

smrcount=`grep -c '<dbReference type="SMR"' uniprot.xml`
entrycount=`grep -c  '<entry dataset=' uniprot.xml`
echo $entrycount" uniprot entrys have been found."
echo $smrcount" uniprot entrys have PDB structure."

#Make Directory
if [ -d "./pdbs/" ];then
        echo "Directory pdbs already exists, pdb files will saved into pdbs."
else
        mkdir pdbs
fi

if [ -d "./chains/" ];then
        echo "Directory chains already exists, pdb files of catched chains will saved into chains."
else
        mkdir chains
fi

#Check Job record Files
if [ -f "./PDBID" ]; then
	echo "File PDBID already exists, replaced."
	rm ./PDBID
else
	echo "File created:PDBID"
fi

if [ -f "./Chain" ]; then
        echo "File Chain already exists, replaced."
        rm ./Chain
else
        echo "File created:Chain"
fi

#Generate PDB_Chain information
grep '<dbReference type="PDB" id="....">' uniprot.xml | while read line
do
	echo ${line:28:4} >> PDBID
done

linecount=`sed -n '$=' PDBID`
echo $linecount" pdbs have been found."

grep '<property type="chains" value=".........' uniprot.xml | while read line
do
	echo ${line:31:1} >> Chain
done

chaincount=`sed -n '$=' Chain`
echo $chaincount" chains have been found."

paste -d "_" PDBID Chain > pdb-chain

#Check pdb and chain number
if [[ $chaincount == $linecount ]]
then
        echo "Note: The frist chain described in your xml file will be choosen to catch out."
else
        echo "Error: The PDB Number can't match to Chain Number, Please check your xml file!"
fi

#Generate get-pdb job control file and Check Chain library
cd ./chains
for file in *.pdb
do
	echo ${file:0:6} >> ../catched
done
cd ..

grep -v -f catched pdb-chain > getpdb

jobcount=`sed -n '$=' getpdb`
count=$[ linecount-jobcount ]
echo "Note: "$count" chains in this jobs have been catched."
rm catched

echo ""

#Download pdb File and Generate PDB_Chain File
if [[ $jobcount == "" ]]; then
	echo  "Warning: All protein you submmited are in our library, No Get-PDB job found, skip it."
else
	echo "Note: "$jobcount" pdbs will be processed in this job."
for line in `cat getpdb`:
do
	wget -P pdbs https://files.rcsb.org/download/${line:0:4}.pdb 
	grep " ${line:5:1} " ./pdbs/${line:0:4}.pdb > ./chains/${line:0:4}_${line:5:1}.pdb
	echo "Note: "${line:0:4}"_"${line:5:1}"has been writen."
done
fi

wait

#No PDB protein
if [ -f "Entry_list.txt" ];then
	echo "Entry_list.txt has been found."
	grep '<dbReference type="SMR"' uniprot.xml | while read line
	do
		echo ${line:28:6} >> xmlwithpdbs
	done
grep -v -f xmlwithpdbs Entry_list.txt > NopdbsProtein.txt
Nopdbsproteincount=`sed -n '$=' NopdbsProtein.txt`
echo "Important: "$Nopdbsproteincount" Protein Entrys without PDB Structure have been writen in NopdbsProtein.txt"
mkdir fasta
cd fasta
for entry in `cat ../NopdbsProtein.txt`
do
	wget https://www.uniprot.org/uniprot/${entry:0:6}.fasta
done
else
	echo "Entry_list.txt Not found."
fi

exit
