#!/bin/bash

for i in {1..5}
do
  LLC_SIZE=$((1024*2**$i))
  #echo $LLC_SIZE
  #sed -i "s/#define LLC_SET NUM_CPUS*.*/#define LLC_SET NUM_CPUS*${LLC_SIZE}/g" "/home/prabh/ChampSim/inc/cache.h"
  
  #bash ./build-bins.sh ${LLC_SIZE}
  
  bash ./run-ml.sh 50 200 ${LLC_SIZE}
  
done
