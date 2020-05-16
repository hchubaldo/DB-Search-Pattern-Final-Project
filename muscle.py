from Bio.Align.Applications import MuscleCommandline
import subprocess

muscle_exe = "muscle.exe"
in_file = "bigFile.fasta"
out_file = "aligned.fasta"
muscle_cline = MuscleCommandline(muscle_exe, input=in_file, out=out_file)
print(muscle_cline)
muscle_result = subprocess.check_output([muscle_exe, "-in", in_file, "-out", out_file])