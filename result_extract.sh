#!/bin/bash

folders=("/home/prabh/ChampSim/results_1M_LLC_KB/")



#echo config IPC instructions > $output

declare -a BPREDS=("bimodal")
declare -a L1_PREFS=("no")
declare -a L2_PREFS=("no")
declare -a REPLS=("lru")
declare -a CACHE_CONFIGS=("ni")
declare -a APPLICATIONS=("alexnet_500M"
                         "cifar10_500M")

for bpred in "${BPREDS[@]}"
do
    for l1_pref in "${L1_PREFS[@]}"
    do
        for l2_pref in "${L2_PREFS[@]}"
        do
            for repl in "${REPLS[@]}"
            do
                for cache_config in "${CACHE_CONFIGS[@]}"
                do
                    for app in "${APPLICATIONS[@]}"
                    do
                        #echo -n ${app}-${bpred}-${l1_pref}-${l2_pref}-${repl} >> $output
                        output="${app}.csv"
                        echo -n > $output
                        #echo -n ${app} >> $output
                        for dir in "${folders[@]}"
                        do
                            file="$dir/${app}-${bpred}-${l1_pref}-${l2_pref}-${repl}-1core-${cache_config}-no-no-.txt"
                            while IFS= read line 
                            do
                                if [[ "$line" =~ "[L1D]" ]] ; 
                                then
                                #echo $line 
                                b=$( echo $line | awk -F: '{print $4}' | awk -F' ' '{print $1}'); 
                                c=$( echo $line | awk -F: '{print $5}' | awk -F' ' '{print $1}');
                                echo "$c,$b" >> $output;
                                echo "$c,$b"
                                fi
                                #if [[ $line =~ MPKI ]] ; 
                                #then 
                                #echo $line | awk -F: '{print $3}'
                                #c=$( echo $line | awk -F: '{print $3}'); 
                                #fi
                            done <"$file"
                        done
                        #echo >> $output
                    done
                done
            done
        done
    done
done
