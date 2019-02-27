import matplotlib.pyplot as plt
import numpy as np
import csv
file = open('memory_access_patter_inception_500M.csv',"r")
partition=[1.4e13,1.402e14]
reader = csv.reader(file)
def index(address):
    j=0
    found=0
    for i in range(0,len(partition)):
        if(address>partition[i]):
            j=i+1
    return j
access=[]
time=[]
mem_add=[]
cycle=[]
for i in range(0,len(partition)+1):
    mem_add.append([])
    cycle.append([])
i=0
for line in reader:
    if(i<20000):
        w=[float(line[0]),float(line[1])]
        j=index(w[1])
        access.append(w[1])
        time.append(w[0])
        mem_add[j].append(w[1])
        cycle[j].append(w[0])
    i=i+1
for i in range(0,len(partition)+1):
    plt.plot(cycle[i],mem_add[i],'o')
    plt.grid('True','both','both')
    plt.title('Inception_memory_access')
    plt.savefig('Inception_memory_access'+str(i)+'.png')
    plt.show()
