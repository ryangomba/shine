import csv
import os
import glob

# COMPILE FAILS

def split():
	global path
	global file
	
	r = csv.reader(file)
	
	oldNum = 0
	new_file = open(path + '_0.csv', 'w+')
	
	for line in r:
		div = (int(line[1])-1)/100000 + 1
		if not div == oldNum:
			oldNum = div
			new_file.close()
			new_file = open(path + '_' + str(oldNum) + '.csv', 'a+')
		new_file.write(line[0]+','+line[1]+','+line[2]+','+line[3]+','+line[4]+','+line[5]+','+line[6]+','+line[7]+','+line[8]+','+line[9]+','+line[10]+','+line[11]+','+line[12]+'\n')	
	
	new_file.close()

# THE PROGRAM

path = '/Users/Ryan/Desktop/yrno/records/records_76'
file = open(path + '.csv','r')

split()

file.close()