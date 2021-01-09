GetPDB
=======
A linux shell script with julia BioStrucures Package to download and spilt PDB from Uniprot ID list.

Uniprot input example:  

        Q9BWF2  
        P19474  
        P36406  
        O15164  
        Q14258  

This script will download related PDB files, extract chains(Optional), remove duplicates(Optional, maybe lost some conformation changed structures) and save as "UniprotID-PDBID-ModelID-ChainID.pdb/cif".

Installtion
----

At frist, you need dwonload a julia package from [Julia Download](https://julialang.org/downloads/).

Then, move julia package and GetPDB to your /home/software or anywhere you like.

        echo "alias GetPDB=${PWD}/GetPDB" >> ~/.bashrc
        chmod +x GetPDB
        tar zxvf julia-1.5.3-linux-x86_64.tar.gz
        cd julia-1.5.3/bin
        echo "export PATH=${PWD}:\$PATH" >> ~/.bashrc
        source ~/.bashrc
        julia
        ]add BioStructures
        exit()
        
I'm going to convert the Julia part used in GetPDB into an executable to avoid cumbersome installation of Julia, and maybe you'll see this update in the near future.

Optionally, if you use windows to process your Uniprot list files frequently, you need install a dos2unix used to convert your dos text format to unix(linux), don't worry how to use it, GetPDB will convert it automatic。

        sudo apt install dos2unix

Now, you can download Bio-Structures form your Uniprot list in your working directory！

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
    -w    Use -w instead of -l unless you know what you're doing.
 
    Output parameter: 
    -o    Processed PDB files will store in this Path, default is Uniprot-PDB.  
    -d    A dir to store some list of Uniprot-PDBID-Chainid info, defult is Uniprot-info-list.  
    -p    Output a Representative chain per Uniprot's PDB Entry. Such as PXXXXX:XXXX_A/B, only XXXX_A will be output. Defult is false.   
    -r    Each sequence interval preserves only one representative structure. Defult is false.   
          Such as P00000:XXXX_A:27-213 and P00000:ZZZZ_A:27-213, only one of them will be saved. 
 
The project is still in its inital stage, Feel free to help with suggestions and contibutions. 
