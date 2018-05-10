import sys
from twisted.web import client
from twisted.internet import reactor, defer
import csv
import codecs
import yrno_add

jump=5
csv.field_size_limit(1000000000)
file = open('/Users/Ryan/Desktop/yrno/yrno-endpoints.txt','rb')
r = csv.reader(file)
urls = []
done = 0
url_num = 0

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
	global done
	global url_num
	urls = []
	print 'MAKING BULK REQUEST:'
	j=0
	while j<jump:
		try:
			nextURL = r.next()[0]+'forecast.xml'
			print nextURL
			urls.append(nextURL)
		except Exception, e:
			done = 1
		j += 1
	url_num += jump
	waiting = [client.getPage(url) for url in urls]
	defer.gatherResults(waiting).addCallback(finish).addErrback(errored)

# success
def finish(results):
	global url_num
	print 'SUCCESS: ' + str(url_num) + ' DONE'
	for result in results:
		yrno_add.parse_and_save(result)
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
load()
reactor.run()
file.close()
print 'All done'