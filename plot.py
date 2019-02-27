import matplotlib.pyplot as plt
import numpy as np
import csv

path = '/home/prabh/ChampSim/results_200M_'

file = open(path + "result.csv","r")
reader = csv.reader(file)

apps=[]
x=[]
y=[]
z=[]

for line in reader:
  #print(apps)
  apps.append(line[0].split('_')[0])
  x.append(float(line[1]))
  y.append(float(line[2]))
  z.append(float(line[3]))

width=0.3
ind = np.arange(10)
fig = plt.figure()
ax = fig.add_subplot(111)

rects1 = ax.bar(ind, x, width, color='y')
rects2 = ax.bar(ind+width, y, width, color='g')
rects3 = ax.bar(ind+width*2, z, width, color='b')

ax.set_ylabel('IPC')
ax.set_xticks(ind+width)
ax.set_xticklabels(apps)
ax.legend( (rects1[0], rects2[0], rects3[0]), ('L2=128kB', 'L2=256kB', 'L2=512kB') ) #to be updated all time

plt.show()


