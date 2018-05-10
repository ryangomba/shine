import csv

# COMPILE FAILS

file = open('/Users/Ryan/Desktop/yrno/records/_fails.txt','r')
r = csv.reader(file)

i = 0
for line in r:
	i += 1
	
print i

file.close()