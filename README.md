GetPDB
=======
[![DOI](https://zenodo.org/badge/228327516.svg)](https://zenodo.org/badge/latestdoi/228327516)

A linux shell script with julia BioStrucures Package to download and spilt PDB from Uniprot ID list.

Uniprot input example:  

        Q9BWF2  
        P19474  
        P36406  
        O15164  
        Q14258  

![image](https://github.com/Wang-Lin-boop/GetPDB/blob/master/img/Uniprot.png)

This script will download related PDB files, extract chains(Optional), remove duplicates(Optional, maybe lost some conformation changed structures) and save as "UniprotID-PDBID-ModelID-ChainID.pdb/cif".

![image](https://user-images.githubusercontent.com/58931275/210138300-5600376b-e47c-4be9-9208-30c2c1be3038.png)

Installation
----

Change dictiontory to your /home/software or anywhere you like, run these commands as follow: (If you are using the Windows 10, then the WSL(Linux Subsystem) is a good choice.)

        git clone https://github.com/Wang-Lin-boop/GetPDB
        cd GetPDB
        echo "alias GetPDB=${PWD}/GetPDB" >> ~/.bashrc
        chmod +x GetPDB
        cd ..
        wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz
        tar zxvf julia-1.5.3-linux-x86_64.tar.gz  
        cd julia-1.5.3/bin
        echo "export PATH=${PWD}:\$PATH" >> ~/.bashrc
        source ~/.bashrc
        julia
        ]add BioStructures # in Julia REPL
        exit()

If you've got installed [Julia](https://julialang.org/downloads/), I believe you know which of the commands above should be removed.

I'm about to convert the Julia part used in GetPDB into an executable to avoid cumbersome installation of Julia, and maybe you'll see this update in the near future.

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
 
How to cite
----
It is recommended that citing the script by a link (such as: `GetPDB(https://github.com/Wang-Lin-boop/GetPDB)`) or refer to this page [Ways to cite a GitHub Repo](https://www.wikihow.com/Cite-a-GitHub-Repository) to promote reproducibility of your work.


GetPDB
===
一个用于根据UniprotID的列表下载PDB结构的脚本（包含依据序列编号去冗余、去除无关Chain的功能），可用于准备靶标垂钓中的蛋白质结构输入、蛋白质结构的调研等；

你需要准备一个像下面这样的Uniprot列表文件，这可以很容易的从Uniprot的搜索结果中下载:  

        Q9BWF2  
        P19474  
        P36406  
        O15164  
        Q14258  

![image](https://github.com/Wang-Lin-boop/GetPDB/blob/master/img/Uniprot.png)

GetPDB会接受您传入的Uniprot列表文件，然后将这些UniprotID相关的PDB下载后依据您指定的参数进行去冗余、去除多余链等处理，之后保存为"UniprotID-ModelID-ChainID.pdb/cif" 的格式（当电镜结构中诸如chain name为AAA的链无法保存为PDB时，才会保存为cif）。

安装
----
首先，选择一个你喜欢的目录：，然后执行下面的Linux命令：（如果你是用的是Windows系统，那么Linux子系统是个不错的选择）

        git clone https://github.com/Wang-Lin-boop/GetPDB
        cd GetPDB
        echo "alias GetPDB=${PWD}/GetPDB" >> ~/.bashrc
        chmod +x GetPDB
        cd ..
        wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz
        tar zxvf julia-1.5.3-linux-x86_64.tar.gz
        cd julia-1.5.3/bin
        echo "export PATH=${PWD}:\$PATH" >> ~/.bashrc
        source ~/.bashrc
        julia
        ]add BioStructures #在Julia交互式会话下
        exit()

如果你已经安装了Julia，那么我想你一定知道该怎么做~

我正在试图将GetPDB中的Julia部分编译为可执行文件，以避免用户需要安装Julia。

如果您需要经常使用Windows生成文本文件（比如使用记事本），那么推荐您在您执行GetPDB的Linux系统下安装一个dos2unix。

        sudo apt install dos2unix

现在，您可以使用GetPDB来下载您的Uniprot列表中所有相关的蛋白了，执行GetPDB -h 尝试一下吧~

示例
----
首先，将你的UniprotID存入Uniprot_list文件，随后依据以下示例执行：

1-下载相关PDB用于结构调研：

                GetPDB -i Uniprot_list -w -o Uniprot-PDB -n 10

执行此命令会使用当前系统10个线程来运行GetPDB，自动获取输入的Uniprot ID 最新的PDB信息并下载到Uniprot-PDB路径下。

2-下载相关PDB并拆分成单链

                GetPDB -i Uniprot_list -w -o Uniprot-PDB -n 10 -p -r
                
执行此命令会获取输入UniprotID的所有结构并依据序列的区间进行去冗余化处理，但这样处理可能损失一些相同序列区间范围但构象发生变化的结构，去掉-r可以避免这一问题。

****

The project is still in its inital stage, Feel free to help with suggestions and contibutions.   

项目开发中，如有建议，欢迎指出。

        
