# Used to import Entrez from Biopython
from Bio import Entrez

# Not required to have an account but can do more calls if you do have one
Entrez.email = "hhcorado@gmail.com"

# Opens file that conatins the list Accession Nums we are looking for
inFile = open("ID_LIST.txt", "r")

#reads in the first line
id = inFile.readline()

# The following while loop removes the new line at the end of each acc number
# then creates a string that will hold the name of the file. We open the
# aformentioned file with "write" priveleges. The handle is used to access
# the nucleotide database for each different accession number passed to it.
# The handle returns fasta type in text. I save the output into a data
# variable and close the fetch handle. Last I write the data to the outFile
# we previously opened and read in the next line.
while(id):
    id = id.strip("\n")
    outputFile = f"{id}.fasta"
    outFile = open(outputFile, "w")
    fetch_handle = Entrez.efetch(db="nucleotide", id=id, rettype="fasta", retmode="text")
    data = fetch_handle.read()
    fetch_handle.close()
    outFile.write(data)
    id = inFile.readline()
    
inFile.close()  # Closes the infile
outFile.close() # Closes the outFile

# This block of code pretty much does the same thing as the code above but
# instead of putting each accession number into its own fasta file this
# puts it all into one file so that it can be used with MUSCLE
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
inFile.close()  # Closes the infile
f.close() # closes the bigFile
