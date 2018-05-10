import csv

endpoints = open('/Users/Ryan/Dropbox/Projects/Shine App/Data/yrno/endpoints.csv','r')
fails = open('/Users/Ryan/Dropbox/Projects/Shine App/Data/yrno/records/_fails.txt','r')
failed_endpoints = open('/Users/Ryan/Dropbox/Projects/Shine App/Data/yrno/records/failed_endpoints.csv','w+')

r = csv.reader(endpoints)

endpointID = 0
endpoint = []

for fail in fails:
    failID = int(fail)
    while endpointID < failID:
        endpointID += 1
        endpoint = r.next()
    failed_endpoints.write(endpoint[0] + ',' + endpoint[1] + '\n')
    
endpoints.close()
fails.close()
failed_endpoints.close()