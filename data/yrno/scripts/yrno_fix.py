#file = open('/Users/Ryan/Desktop/yrno-endpoints-1.txt','rw')
file1 = open('/Users/Ryan/Desktop/yrno-endpoints.txt','r')
file2 = open('/Users/Ryan/Desktop/yrno-endpoints-9.txt','r')
c1 = file1.read()
c2 = file2.read()
file1.close()
file2.close()
file = open('/Users/Ryan/Desktop/yrno-endpoints.txt','w+')
file.write(c1+c2)
file.close()