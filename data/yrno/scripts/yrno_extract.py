import xml.sax
import codecs

class XMLHandler(xml.sax.handler.ContentHandler):
    def __init__(self):
        self.inURL = 0
        self.hasBuffer = 0
        self.urlCount = 0
        self.urls = ''
        
    def startElement(self, name, attributes):
    	self.hasBuffer = 0
        if name == "loc":
        	self.buffer = ""
        	self.inURL = 1
            
    def characters(self, data):
        if self.inURL:
            if (data.startswith('http://www.yr.no/place')):
                if (data.endswith('/')):
                	self.hasBuffer = 1
                	self.buffer += data
            
    def endElement(self, name):
        if name == "loc":
            self.inURL = 0
            if (self.hasBuffer):
                self.urls += self.buffer + '\n'
                self.urlCount += 1

def parseFile(url):
    parser = xml.sax.make_parser()
    handler = XMLHandler()
    parser.setContentHandler(handler)
    parser.parse(url)
    return [handler.urls,handler.urlCount]

f = codecs.open('/Users/Ryan/Desktop/yrno-endpoints-1.csv', encoding='utf-8', mode='w+')

i = 1
count = 0;
while i <= 1000:
    indexStr = '%06d' % i
    url = '/Users/Ryan/Desktop/yrno-downloaded/' + indexStr + '.xml'
    result = parseFile(url)
    f.write(result[0])
    count += result[1]
    print str(i) + ': ' + str(count)
    i += 1

print count
f.close()