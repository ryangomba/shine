import urllib

url = 'http://www.yr.no/place/Germany/North_Rhine-Westphalia/Bachem/forecast.xml'
request = urllib.urlopen(url)
print request.read()