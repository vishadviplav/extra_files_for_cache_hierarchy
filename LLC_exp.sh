#!/bin/bash

#echo config IPC instructions > $output
echo start
declare -a BPREDS=("bimodal")
declare -a L1_PREFS=("no" "next_line")
declare -a L2_PREFS=("no" "ip_stride")
declare -a REPLS=("lru")
declare -a CACHE_CONFIGS=("ni")
declare -a APPLICATIONS=("alexnet_500M"
                         "cifar10_500M"
                         "inception_500M"
                         "lenet-5_500M"
                         "resnet-50_500M"
                         "squeezenet_500M"
                         "svhn_500M"
                         "vgg-16_500M"
                         "vgg-m_500M"
                         "vgg-s_500M")
num=5
for bpred in "${BPREDS[@]}"
do
    for app in "${APPLICATIONS[@]}"
    do
        output="result_IPC_LLC_${app}.csv"
        for i in {1..10}
        do  
            LLC_SIZE=$((1024*2**$i))
            echo $LLC_SIZE, $i
            if  (("$i" <= "$num" )) ;then 
            folder="/home/prabh/ChampSim/results_200M_LLC_${LLC_SIZE}KB"
            suffix="${LLC_SIZE}"
            else
            folder="./results_200M_LLC_${LLC_SIZE}KB"
            suffix="LLC_SIZE-${LLC_SIZE}"
            fi
            echo $folder
            echo -n $LLC_SIZE >> $output;
            for l1_pref in "${L1_PREFS[@]}"
            do
                for l2_pref in "${L2_PREFS[@]}"
                do
                    for repl in "${REPLS[@]}"
                    do
                        for cache_config in "${CACHE_CONFIGS[@]}"
                        do
                            #echo -n ${app}-${bpred}-${l1_pref}-${l2_pref}-${repl} >> $output
                            
				            file="$folder/${app}-${bpred}-${l1_pref}-${l2_pref}-${repl}-1core-${cache_config}-no-no-${suffix}.txt"
                            while IFS= read line 
                            do
                                if [[ $line =~ Finished ]] ; 
                                then 
                                b=$( echo $line | awk -F: '{print $4}' | awk -F' ' '{print $1}'); 
                                fi
                            done <"$file"
                            echo -n ",$b">> $output;
                        done
                    done
                done
            done
            echo >>$output; 
        done
    done
done
