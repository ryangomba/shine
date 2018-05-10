import csv
import os
import glob

types = []

path = '/Users/Ryan/Desktop/yrno/records/'
fails = open(path +'_fails.txt','a+')
listing = os.listdir(path)
for infile in glob.glob(os.path.join(path,'*.csv')):
	print infile
	file = open(infile,'r')
	r = csv.reader(file)
	for line in r:
		if len(line) > 8:
			new = 1
			for t in types:
				if t == line[8]:
					new = 0
			if new:
				types.append(line[8])
	file.close()
	print len(types)
	
print types