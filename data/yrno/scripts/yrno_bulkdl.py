import sys
from twisted.web import client
from twisted.internet import reactor, defer
import csv
import codecs

import urlparse, urllib

def fixurl(url):
    # turn string into unicode
    if not isinstance(url,unicode):
        url = url.decode('utf8')

    # parse it
    parsed = urlparse.urlsplit(url)

    # divide the netloc further
    userpass,at,hostport = parsed.netloc.partition('@')
    user,colon1,pass_ = userpass.partition(':')
    host,colon2,port = hostport.partition(':')

    # encode each component
    scheme = parsed.scheme.encode('utf8')
    user = urllib.quote(user.encode('utf8'))
    colon1 = colon1.encode('utf8')
    pass_ = urllib.quote(pass_.encode('utf8'))
    at = at.encode('utf8')
    host = host.encode('idna')
    colon2 = colon2.encode('utf8')
    port = port.encode('utf8')
    path = '/'.join(  # could be encoded slashes!
        urllib.quote(urllib.unquote(pce).encode('utf8'),'')
        for pce in parsed.path.split('/')
    )
    query = urllib.quote(urllib.unquote(parsed.query).encode('utf8'),'=&?/')
    fragment = urllib.quote(urllib.unquote(parsed.fragment).encode('utf8'))

    # put it back together
    netloc = ''.join((user,colon1,pass_,at,host,colon2,port))
    return urlparse.urlunsplit((scheme,netloc,path,query,fragment))

jump=2
csv.field_size_limit(1000000000)
file = open('/Users/Ryan/Desktop/yrno/yrno-endpoints-csv.txt','rb')
r = csv.reader(file)
urls = []
ids = []
done = 0
saveURL = '/Users/Ryan/Desktop/yrno-downloaded/'

# check if we need to keep loading
def load():
	global done
	if done:
		reactor.stop()
	else:
		go()

# load
def go():
	global r
	global jump
	global urls
	global ids
	global done
	urls = []
	ids = []
	print 'MAKING BULK REQUEST:'
	j=0
	while j<jump:
		try:
			next = r.next()
			nextURL = next[0]+'forecast.xml'
			nextID = next[1]
			print nextID
			print nextURL
			urls.append(nextURL)
			ids.append(nextID)
		except Exception, e:
			done = 1
		j += 1
	waiting = [client.getPage(fixurl(url)) for url in urls]
	defer.gatherResults(waiting).addCallback(finish).addErrback(errored)

# success
def finish(results):
	global saveURL
	i = 0
	for result in results:
		file = open(saveURL+ids[i]+'.xml','w+')
		file.write(result)
		file.close()
		i += 1
	load()

# failure
def errored(error):
	global urls
	print "REQUESTS FAILED"
	fail_string = ''
	for url in urls:
		fail_string += url + '\n'
	fail_log = open('/Users/Ryan/Desktop/yrno/failures.txt','a')
	fail_log.write(fail_string)
	fail_log.close()
	load()

# do it
f=0
while f<3335:
	r.next()
	f += 1
	
load()
reactor.run()
file.close()
print 'All done'