import csv

file1 = open('/Users/Ryan/Desktop/yrno/yrno-endpoints.txt','r')
file2 = open('/Users/Ryan/Desktop/yrno/yrno-endpoints-dedup.txt','w+')

r = csv.reader(file1)

records = 0
dupes = 0
new = ''
last = ''
for line in r:
	#print line
	records += 1
	#print 'record:' + str(records)
	if line == last:
		dupes += 1
		#print 'dupes: ' + str(dupes)
	else:
		new += line[0] + '\n'
	last = line

print records
print dupes
file2.write(new)
file2.close()
file1.close()