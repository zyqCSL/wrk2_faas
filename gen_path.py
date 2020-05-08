import sys;
import os;

of = open("paths.txt", "w")
infile = open("raw_paths.txt", "r")

lines = infile.readlines()
for line in lines:
	p = "/" + line
	of.write(p)

infile.close()
of.close()
