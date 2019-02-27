import matplotlib.pyplot as plt
import numpy as np
import csv
file = open('alexnet_500M.csv',"r")
# partition=[1.4e13,1.402e14]
reader = csv.reader(file)
# def index(address):
#     j=0
#     found=0
#     for i in range(0,len(partition)):
#         if(address>partition[i]):
#             j=i+1
#     return j
# access=[]
# time=[]
# mem_add=[]
# cycle=[]
# for i in range(0,len(partition)+1):
#     mem_add.append([])
#     cycle.append([])
# i=0
# for line in reader:
#     if(i<20000):
#         w=[float(line[0]),float(line[1])]
#         j=index(w[1])
#         access.append(w[1])
#         time.append(w[0])
#         mem_add[j].append(w[1])
#         cycle[j].append(w[0])
#     i=i+1
# for i in range(0,len(partition)+1):

i=0
cycle=[]
mem_add=[]
for line in reader:
    if(i<6000000):
        cycle.append(float(line[0]))
        mem_add.append(float(line[1]))
    else:
        break
    i=i+1


plt.plot(cycle,mem_add,'o')
plt.grid('True','both','both')
plt.title('alexnet_memory_access')
plt.savefig('alexnet_memory_access'+'.png')
plt.show()
