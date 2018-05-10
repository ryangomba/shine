import csv
import urllib

csv.field_size_limit(1000000000)
file = open('/Users/Ryan/Desktop/yrno/yrno-endpoints-csv.txt','rb')
r = csv.reader(file)

saveURL = '/Users/Ryan/Desktop/yrno-downloaded/'

i=0
while i<3335:
	r.next()
	i += 1

while 1:
	i += 1
	print i
	next = r.next()
	url = next[0]+'forecast.xml'
	id = next[1]
	urllib.urlretrieve(url, saveURL + str(id) + '.xml')