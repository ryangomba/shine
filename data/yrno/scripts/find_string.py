file = open('/Users/Ryan/Dropbox/Projects/Shine App/Data/yrno/endpoints.csv','r')

i = 0

for line in file:
    i += 1
    if line.find('ich/Zurich') > 0:
        print line
        
file.close()