#!/bin/bash
output="result.csv"
echo config,IPC,instructions,L1D-MISSES,L1I-MISSES,L2C-MISSES,LLC-MISSES>> result
declare -a BPREDS=("bimodal")
declare -a L1_PREFS=("no")
declare -a L2_PREFS=("no")
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
LLC_SETS=2048
L2_SETS=512
L1D_SETS=128
L1I_SETS=64

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
                        file="${app}-${bpred}-${l1_pref}-${l2_pref}-${repl}-1core-${cache_config}-no-no.txt"
                        while IFS= read line 
                        do
                            if [[ $line =~ Finished ]] ; 
                            then 
                            b=$( echo $line | awk -F: '{print $4}' | awk -F' ' '{print $1}'); 
                            c=$( echo $line | awk -F: '{print $2}' | awk -F' ' '{print $1}'); 
                            fi
                            if [[ $line =~ L1D && $line =~ TOTAL ]] ; 
                            then d=$( echo $line | awk -F: '{print $4}' | awk -F' ' '{print $1}'); 
                            fi
                            if [[ $line =~ L1I && $line =~ TOTAL ]] ; 
                            then e=$( echo $line | awk -F: '{print $4}' | awk -F' ' '{print $1}'); 
                            fi
                            if [[ $line =~ L2C && $line =~ TOTAL ]] ; 
                            then f=$( echo $line | awk -F: '{print $4}' | awk -F' ' '{print $1}'); 
                            fi
                            if [[ $line =~ LLC && $line =~ TOTAL ]] ; 
                            then g=$( echo $line | awk -F: '{print $4}' | awk -F' ' '{print $1}'); 
                            fi
                        done <"$file"
                        echo ${app}-${bpred}-${l1_pref}-${l2_pref}-${repl},"$b","$c","$d","$e","$f","$g">> result;
                    done
                done
            done
        done
    done
done
mv result result_"$LLC_SETS"_"$L2_SETS"_"$L1D_SETS"_"$L1I_SETS"_no_prefetcher.csv
