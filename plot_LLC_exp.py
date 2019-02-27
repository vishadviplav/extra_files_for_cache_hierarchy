import matplotlib.pyplot as plt
import numpy as np
import csv
traces={'alexnet_500M','cifar10_500M','inception_500M','lenet-5_500M','resnet-50_500M','squeezenet_500M','svhn_500M','vgg-16_500M','vgg-m_500M','vgg-s_500M'}
path = '/home/prabh/ChampSim/results_200M_'
size_gm=[]
w_gm=[]
x_gm=[]
y_gm=[]
z_gm=[]
j=0
for trace in traces:
    file = open('result_IPC_LLC_'+trace+'.csv',"r")
    reader = csv.reader(file)
    size=[]
    w=[]
    x=[]
    y=[]
    z=[]
    i=0
    for line in reader:
        size.append(float(line[0])/1024)
        if(i==0):
            w.append(float(line[1]))
            x.append(float(line[2]))
            y.append(float(line[3]))
            z.append(float(line[4]))
        else:
            w.append(float(line[1])/w[0])
            x.append(float(line[2])/x[0])
            y.append(float(line[3])/y[0])
            z.append(float(line[4])/z[0])
        i=i+1
    width=0.2
    w[0]=1
    x[0]=1
    y[0]=1
    z[0]=1
    ind = np.arange(10)
    fig = plt.figure()
    ax = fig.add_subplot(111)
    minn = min(min(w),min(x),min(y),min(z))-0.02
    print(minn)
    size_gm=size
    for i in range(0,len(w)):
        if(j==0):
            w_gm.append(w[i])
            x_gm.append(x[i])
            y_gm.append(y[i])
            z_gm.append(z[i])
        else:
            w_gm[i]=w_gm[i]*w[i]
            x_gm[i]=x_gm[i]*x[i]
            y_gm[i]=y_gm[i]*y[i]
            z_gm[i]=z_gm[i]*z[i]
    for i in range(0,len(w)):
        w[i]=w[i]-minn
        x[i]=x[i]-minn
        y[i]=y[i]-minn
        z[i]=z[i]-minn
    rects1 = ax.bar(ind, w, width, minn, color='y')
    rects2 = ax.bar(ind+width, x, width, minn, color='g')
    rects3 = ax.bar(ind+width*2, y, width, minn, color='b')
    rects4 = ax.bar(ind+width*3, z, width, minn, color='r')

    ax.set_ylabel('Normalized IPC')
    ax.set_xlabel('Size of LLC in MB')
    ax.set_xticks(ind+width)
    ax.set_xticklabels(size_gm)
    ax.legend( (rects1[0], rects2[0], rects3[0], rects4[0]), ('no_no', 'no_ip_stride', 'next_line_no', 'next_line_ip_stride') ) #to be updated all time
    plt.title(trace)
    #plt.show()
    j=j+1
n=len(traces)
width=0.2
ind = np.arange(10)
fig = plt.figure()
ax = fig.add_subplot(111)
print(w_gm)
minn = min(min(w_gm),min(x_gm),min(y_gm),min(z_gm))-0.02
print(minn)
for i in range(0,len(w)):
    w_gm[i]=pow(w_gm[i],1/n)-minn
    x_gm[i]=pow(x_gm[i],1/n)-minn
    y_gm[i]=pow(y_gm[i],1/n)-minn
    z_gm[i]=pow(z_gm[i],1/n)-minn
rects1 = ax.bar(ind, w_gm, width, minn, color='y')
rects2 = ax.bar(ind+width, x_gm, width, minn, color='g')
rects3 = ax.bar(ind+width*2, y_gm, width, minn, color='b')
rects4 = ax.bar(ind+width*3, z_gm, width, minn, color='r')

ax.set_ylabel('Normalized IPC')
ax.set_xlabel('Size of LLC in MB')
ax.set_xticks(ind+width)
ax.set_xticklabels(size_gm)
ax.legend( (rects1[0], rects2[0], rects3[0], rects4[0]), ('no_no', 'no_ip_stride', 'next_line_no', 'next_line_ip_stride') ) #to be updated all time
plt.title('GeoMean')
plt.show()