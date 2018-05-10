import urllib

saveURL = '/Users/Ryan/Desktop/yrno-downloaded/'
group = 1
index = 1
url = 'http://www.yr.no/sitemap-'

while group <= 1:
    groupStr = '%03d' % group
    while index <= 1000:
        indexStr = '%06d' % ((group-1)*1000 + index)
        urllib.urlretrieve(url + groupStr + '-' + indexStr + '.xml.gz', saveURL + indexStr + '.xml.gz')
        index+=1
    group +=1

# end <= 9640