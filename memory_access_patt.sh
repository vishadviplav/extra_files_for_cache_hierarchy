#!/bin/bash

#echo config IPC instructions > $output
echo start
declare -a BPREDS=("bimodal")
declare -a L1_PREFS=("no")
declare -a L2_PREFS=("no")
declare -a REPLS=("lru")
declare -a CACHE_CONFIGS=("ni")
declare -a APPLICATIONS=("vgg-16_500M"
                         "vgg-m_500M"
                         "vgg-s_500M")
folder="./results_2M"
for bpred in "${BPREDS[@]}"
do
    for app in "${APPLICATIONS[@]}"
    do
         output="memory_access_patter_${app}.csv"
    
            for l1_pref in "${L1_PREFS[@]}"
            do
                for l2_pref in "${L2_PREFS[@]}"
                do
                    for repl in "${REPLS[@]}"
                    do
                        for cache_config in "${CACHE_CONFIGS[@]}"
                        do
                            #echo -n ${app}-${bpred}-${l1_pref}-${l2_pref}-${repl} >> $output
                            
				            file="$folder/${app}-${bpred}-${l1_pref}-${l2_pref}-${repl}-1core-${cache_config}-no-no.txt"
                            while IFS= read line 
                            do
                                if [[ $line =~ I_ma ]] 
                                then 
                                b=$( echo $line | awk -F: '{print $2}'); 
                                c=$( echo $line | awk -F: '{print $3}');
                                	if [[ $c =~ ^[-+]?[0-9]+$ ]] 
                                    then
                                    echo "$b,$c">> $output;
                                    fi
                                fi
                            done <"$file"
                            
                        done
                    done
                done
            done
             
        
    done
done
