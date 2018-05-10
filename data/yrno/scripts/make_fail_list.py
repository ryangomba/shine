import csv
import os
import glob

# COMPILE FAILS

def compile_fails(fileURL):
	global numFails
	global fails
	global restart
	file = open(fileURL,'r')
	r = csv.reader(file)

	start = int(r.next()[1])
	i = start
	current = i
	end = 0
	
	while i<=start+100000:
		#if end > 0:
			#restart = i
			#break
		if not current == i:
			fails.write(str(i) + '\n')
			numFails += 1
		else:
			try:
				current = int(r.next()[1])
			except:
				end += 1
		i += 1
	
	
	file.close()

# THE PROGRAM

restart = 0
numFails = 0

path = '/Users/Ryan/Desktop/yrno/records/'
fails = open(path +'_fails.txt','a+')
listing = os.listdir(path)
for infile in glob.glob(os.path.join(path,'*.csv')):
	compile_fails(infile)
	print infile
	#print "Should restart at " + str(restart)

fails.close()