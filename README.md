GetPDB
=======
A linux shell script with julia BioStrucures Package to download and spilt PDB from Uniprot ID list.

Uniprot input example:  
Q9BWF2  
P19474  
P36406  
O15164  
Q14258  

This script will download related PDB files, extract chains and save as "UniprotID-PDBID-ModelID-ChainID.pdb/cif".

Usage
----

    Usage: GetPDB [OPTION] <parameter> 
  
    Example: GetPDB -i Uniprot_list -w -o Uniprot-PDB -n 10 -p -r 
 
    Input parameter:  
    -i    Your Uniprotlist file.   
    -b    Your PDBlib, optional.   
    -n    The Max number of CPU threads available for this job, default is 4.  
    -l    An index for Uniprot, such as "pdb_chain_uniprot.csv".  
          This file can be download at https://www.ebi.ac.uk/pdbe/docs/sifts/quick.html  
          OR you can use -w download its latest version automatic.  
 
    Output parameter: 
    -o    Processed PDB files will store in this Path, default is Uniprot-PDB.  
    -d    A dir to store some list of Uniprot-PDBID-Chainid info, defult is Uniprot-info-list.  
    -p    Output a Representative chain per Uniprot's PDB Entry. Such as PXXXXX:XXXX_A/B, only XXXX_A will be output. Defult is false.   
    -r    Each sequence interval preserves only one representative structure. Defult is false.   
          Such as P00000:XXXX_A:27-213 and P00000:ZZZZ_A:27-213, only one of them will be saved. 
 
The project is still in its inital stage, Feel free to help with suggestions and contibutions. 
