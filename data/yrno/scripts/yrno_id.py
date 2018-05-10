import csv

file1 = open('/Users/Ryan/Desktop/yrno/yrno-endpoints-csv.txt','r')
file2 = open('/Users/Ryan/Desktop/yrno/yrno-endpoints-csv0.txt','w+')

r = csv.reader(file1)

id = 0
new = ''
for line in r:
	id += 1
	if id <= 4335:
		new_line = line[0] + ',' + line[1] + '\n'
		new += new_line
	else: break

file2.write(new)
file2.close()
file1.close()