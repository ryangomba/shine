import simplegeo
import time
import csv
import sys

from simplegeo import Client
from simplegeo.models import Record
client = Client('SQBJDhg3zB7MdZyrhs7aKvg6ekEMweCZ', 'X3pLbpXrU9Y5bYS4tAsmfWy7X7mSPUXv')

if not len(sys.argv) == 2:
	print 'Need 1 argument.'
	quit()
	
fileNum = sys.argv[1]

file = open('/home/ryan/yrno/records/record_' + fileNum + '.csv','r')
r = csv.reader(file)

done = 0
group = 0
while 1:
	
	i = 0
	records = []
	while i<100:
		i += 1
		try:
			line = r.next()
			record = Record('no.yr.cities', line[2], line[3], line[4], time.time(),
				place_type = line[8],
				name = line[5],
				region = line[6],
				country = line[7],
				timezone = line[9],
				utc_offset = line[10],
				altitude = line[11],
				geobase_id = line[12],
				yrno_url = line[0]
			)
			records.append(record)
		except:
			done = 1
	num = group*100 + i
	print 'Storing ' + str(num - 99) + '-' + str(num)
	client.storage.add_records('no.yr.cities',records)
	if done:
		break
	group += 1
	
print 'All done'