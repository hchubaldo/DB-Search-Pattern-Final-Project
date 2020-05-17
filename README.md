# DB-Search-Pattern-Final-Project
This repository contains my final project for DB Search Patterns

The accession numbers that are needed for the entrezPull.py script are in the ID_LIST.txt file.

Make sure that **ID_LIST.txt** and **entrezPull.py** are in the same directory.
>This block of code is used to generate a large fasta file (named bigFile.fasta) that has the genome of the 9 bacteria.  
>The same script also has another block of code that puts each genome into its own fasta file (each named with the accession number).  

    from Bio import Entrez  
    Entrez.email = "enter-your-email-here@hotmail.com"  
    inFile = open("ID_LIST.txt", "r")  
    type = "fasta"  
    outputFile = "bigFile."+type  
    f = open(outputFile,"w")  
    id = inFile.readline()  
    while(id):  
        id = id.strip("\n")  
        fetch_handle = Entrez.efetch(db="nucleotide", id=id, rettype=type, retmode="text")  
        data=fetch_handle.read()  
        fetch_handle.close()  
        f.write(data)  
        id = inFile.readline()  
    inFile.close()  
    f.close()  

I used neo4j to create a graph database. Each node consists of a the bacteria name, accession number,
base pair count, and the size of the file in kb. The original plan was to include the entire fasta file under
the accesion number but I could not figure out how to do that.

After installing neo4j, launch a local database, setup the password, and go to http://www.lyonwj.com/LazyWebCypher/
On that website you can load in the **cypher_build.cyp** and click on the next tab. You can leave the localhost as is,
username usually defaults to neo4j, and use the password from earlier. Then click import to populate the database.
>The following script creates the hub node (clostridium) and the nodes (different bacteria) connect to that hub node.

    CREATE (Clostridium:Bacteria { name:"Clostridium" })
    CREATE (indolis:Microbiome { name:"Clostridium indulis", acc_num:"NZ_AZUI01000001.1", bp:6383701, size_kb:6313 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
    CREATE (clostridioforme:Microbiome { name:"Clostridium clostridioforme", acc_num:"NZ_KB850936.1", bp:2393545, size_kb:5594 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
    CREATE (orbiscindents:Microbiome { name:"Clostridium orbiscindents", acc_num:"NZ_CP015406.2", bp:3818478, size_kb:3776 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
    CREATE (disporicum:Microbiome { name:"Clostridium disporicum", acc_num:"NZ_CYZX01000001.1", bp:253314, size_kb:3417 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
    CREATE (glycolicus:Microbiome { name:"Clostridium glycolicum", acc_num:"NZ_KE392228.1", bp:2636478, size_kb:3978 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
    CREATE (symbiosum:Microbiome { name:"Clostridium symbiosum", acc_num:"NZ_GL834305.1", bp:907173, size_kb:5298 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
    CREATE (botulinum:Foodborne { name:"Clostridium botulinum", acc_num:"NC_009495.1", bp:3886916, size_kb:3860 })-[:FOUND_IN { location: ["Food"]}]->(Clostridium)
    CREATE (perfringens:Foodborne { name:"Clostridium perfringens", acc_num:"NC_008261.1", bp:3256683, size_kb:3221 })-[:FOUND_IN { location: ["Food"]}]->(Clostridium)
    CREATE (histolytica:Drug { name:"Clostridium histolytica", acc_num:"NZ_LR590481.1", bp:2740791, size_kb:2711 })-[:FOUND_IN { location: ["Drug"]}]->(Clostridium)
    CREATE (butyricum:Drug { name:"Clostridium butyricum", acc_num:"NZ_CP013252.1", bp:3824894, size_kb:4577 })-[:FOUND_IN { location: ["Drug"]}]->(Clostridium)

>The following lines are to perform some sample queries from the graph database that was made. Do these in neo4j by clicking on the
>database being used and copy paste the queries into the query bar.

    /// 1) Return the name and accession numbers of the bacteria only found in the microbiome
    MATCH (m:Microbiome)-[:FOUND_IN]-(:Bacteria)
    RETURN m.name AS NAME, m.acc_num AS ACCESSION NUMBER

    /// 2) Return the name and length (in bp) of all the bacteria in descending order
    MATCH (n)
    RETURN n.name AS NAME, n.bp AS BASE_PAIRS
    ORDER BY n.bp DESC
    SKIP 1'
    
For the analysis portion of the project, I attempted to run a multiple sequence analysis using MUSCLE (run **muscle.py**) and it
takes **bigFile.fasta** as input.  
**If you are using Windows make sure to have windows_muscle.exe in the same directory with muscle.py and bigFile.fasta. If Linux or Mac OSX are being used, please use linux_muscle.tar or osx_muscle.tar, respectively.**
>Change the string held by muscle_exe variable to the one you need if not using Windows. This code runs MUSCLE with the fasta input and returns a file names aligned.fasta as the output with the results.

    from Bio.Align.Applications import MuscleCommandline
    import subprocess

    muscle_exe = "windows_muscle.exe"
    in_file = "bigFile.fasta"
    out_file = "aligned.fasta"
    muscle_cline = MuscleCommandline(muscle_exe, input=in_file, out=out_file)
    print(muscle_cline)
    muscle_result = subprocess.check_output([muscle_exe, "-in", in_file, "-out", out_file])
