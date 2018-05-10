import xml.sax
import unicodedata
import json
import simplegeo
import time
import csv
import os.path

class XMLHandler(xml.sax.handler.ContentHandler):
    def __init__(self):
    	self.type = ''
    	self.name = ''
    	self.region = ''
    	self.country = ''
    	self.timezone = ''
    	self.utc_offset = ''
    	self.altitude = ''
    	self.geobase_id = ''
    	self.yrno_url = ''
    	#location
    	self.latitude = ''
    	self.longitude = ''
    	#parsing
    	self.needData = 0
    	# naming
    	self.inName = 0
    	self.inType = 0
    	self.inCountry = 0
    	# geocode
    	self.inLocation = 0
    	# url
    	self.inURL = 0
        
    def startElement(self, name, attributes):
        if name == 'name':
        	self.needData = 1
        	self.inName = 1
        elif name == 'type':
        	self.needData = 1
        	self.inType = 1
        elif name == 'country':
        	self.needData = 1
        	self.inCountry = 1
        elif name == 'timezone':
        	self.timezone = attributes['id']
        	self.utc_offset = attributes['utcoffsetMinutes']
        elif name == 'location':
        	self.inLocation += 1
        	if self.inLocation == 2:
        		self.altitude = attributes['altitude']
        		self.geobase_id = attributes['geobaseid']
        		self.latitude = attributes['latitude']
        		self.longitude = attributes['longitude']
        elif name == 'link':
        	self.inURL += 1
        	if self.inURL == 1:
        		self.yrno_url = attributes['url']
        		self.yrno_url = self.yrno_url[23:len(handler.yrno_url)-1]
        		self.yrno_url = self.yrno_url.split('~')[0]
            
    def characters(self, data):
        if self.needData:
            self.buffer = data
            
    def endElement(self, name):
    	if self.needData:
	        if name == 'name':
	        	self.name = self.buffer
	        elif name == 'type':
	        	self.type = self.buffer
	        elif name == 'country':
	        	self.country = self.buffer
        	self.needData = 0

def recordFailure(id):
	fail_log = open('/Users/Ryan/Desktop/yrno/compile_failures.txt','a')
	fail_log.write(id + '\n')
	fail_log.close()

file_old = open('/Users/Ryan/Desktop/yrno/yrno-endpoints-csv.txt','r')
file_new = open('/Users/Ryan/Desktop/yrno/yrno-endpoints-csv-new.txt','w+')
r = csv.reader(file_old)

id = 0
new = ''
for line in r:
	id += 1
	if line[1] >= 1: #record at which to start 
		if id < 1000: # number of records to compile
			file_path = '/Users/Ryan/Desktop/yrno-downloaded/' + line[1] + '.xml'
			print line[1]
			if os.path.exists(file_path):
				xml_file = open(file_path,'r')
				xml_string = xml_file.read()
				xml_file.close()
				if not xml_string.startswith('<?x'):
					recordFailure(line[1])
				else:
					# parse the file
					handler = XMLHandler()
					xml.sax.parseString(xml_string, handler)
					# make id
					parts = handler.yrno_url.split('/')
					region = parts[len(parts)-3].replace('_',' ')
					handler.region = region
					recordID = handler.yrno_url
					recordID = unicodedata.normalize('NFKD', recordID).encode('ascii', 'ignore')
					# make new line
					new_line = line[0] + ',' + line[1] + ',' + recordID + ',' + handler.latitude + ',' + handler.longitude + ',' + handler.name + ',' + handler.region + ',' + handler.country + ',' + handler.type + ',' + handler.timezone + ',' + handler.utc_offset + ',' + handler.altitude + ',' + handler.geobase_id + '\n'
					new += new_line
			else:
				recordFailure(line[1])
		else:
			break

file_new.write(new)
file_old.close()
file_new.close()
