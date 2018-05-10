import xml.sax
import unicodedata
import json
import time
import simplegeo

from simplegeo import Client
from simplegeo.models import Record
client = Client('SQBJDhg3zB7MdZyrhs7aKvg6ekEMweCZ', 'X3pLbpXrU9Y5bYS4tAsmfWy7X7mSPUXv')

class XMLHandler(xml.sax.handler.ContentHandler):
    def __init__(self):
    	self.json = {
    		'type': '',
    		'name': '',
    		'region': '',
    		'country': '',
    		'timezone': '',
    		'utc_offset': '',
    		'altitude': '',
    		'geobase_id': '',
    		'yr.no': {
    			'url': '',
    			'last_update': '',
    			'next_update': '',
    			'sunrise': '',
    			'sunset': '',
    			'forecast': [],
    			'attribution': 'Weather forecast from yr.no, delivered by the Norwegian Meteorological Institute and the NRK'
    		}
    	}
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
        # update cycle
        self.inLastUpdate = 0
        self.inNextUpdate = 0
        # forecast
        self.inForecast = -1
        
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
        	self.json['timezone'] = attributes['id']
        	self.json['utc_offset'] = attributes['utcoffsetMinutes']
        elif name == 'location':
        	self.inLocation += 1
        	if self.inLocation == 2:
        		self.json['altitude'] = attributes['altitude']
        		self.json['geobase_id'] = attributes['geobaseid']
        		self.latitude = attributes['latitude']
        		self.longitude = attributes['longitude']
        elif name == 'link':
        	self.inURL += 1
        	if self.inURL == 1:
        		self.json['yr.no']['url'] = attributes['url']
        elif name == 'lastupdate':
        	self.needData = 1
        	self.inLastUpdate = 1
        elif name == 'nextupdate':
        	self.needData = 1
        	self.inNextUpdate = 1
        elif name == 'sun':
        	self.json['yr.no']['sunrise'] = attributes['rise']
        	self.json['yr.no']['sunset'] = attributes['set']
        elif name == 'time':
        	self.needData = 1
        	self.inForecast += 1
        	entry = {
        		'start': attributes['from'],
        		'end': attributes['to'],
        		'period': attributes['period']
        	}
        	self.json['yr.no']['forecast'].append(entry)
        elif name == 'symbol':
        	self.json['yr.no']['forecast'][self.inForecast]['conditions'] = attributes['name']
        elif name == 'precipitation':
        	self.json['yr.no']['forecast'][self.inForecast]['precipitation'] = attributes['value']
        elif name == 'windDirection':
        	self.json['yr.no']['forecast'][self.inForecast]['wind_direction'] = attributes['deg']
        elif name == 'windSpeed':
        	self.json['yr.no']['forecast'][self.inForecast]['wind_speed'] = attributes['mps']
        elif name == 'temperature':
        	self.json['yr.no']['forecast'][self.inForecast]['temperature'] = attributes['value']
        elif name == 'pressure':
        	self.json['yr.no']['forecast'][self.inForecast]['pressure'] = attributes['value']
            
    def characters(self, data):
        if self.needData:
            self.buffer = data
            
    def endElement(self, name):
    	if self.needData:
	        if name == 'name':
	        	self.json['name'] = self.buffer
	        elif name == 'type':
	        	self.json['type'] = self.buffer
	        elif name == 'country':
	        	self.json['country'] = self.buffer
	        elif name == 'lastupdate':
	        	self.json['yr.no']['last_update'] = self.buffer
	        elif name == 'nextupdate':
	        	self.json['yr.no']['next_update'] = self.buffer
	        elif name == 'time':
	        	self.json['yr.no']['forecast'][0] = {'this':'todo'}
        	self.needData = 0

def parse_and_save(result):
	#parse
	#print 'parsing ' + result
	handler = XMLHandler()
	xml.sax.parseString(result, handler)
	#print 'done'
	#manipulate
	yrnoURL = handler.json['yr.no']['url']
	parts = yrnoURL.split('/')
	region = parts[len(parts)-3].replace('_',' ')
	handler.json['region'] = region
	recordID = yrnoURL[23:len(yrnoURL)-1]
	recordID = unicodedata.normalize('NFKD', recordID).encode('ascii', 'ignore')
	#save
	print 'Storing ' + recordID + 'at ' + handler.latitude + ',' + handler.longitude
	#print json.dumps(handler.json)
	r = Record('no.yr.cities', recordID, handler.latitude, handler.longitude,'place', attributes=handler.json)
	#client.storage.add_record(r)
	