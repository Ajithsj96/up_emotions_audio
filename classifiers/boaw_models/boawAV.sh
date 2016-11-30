#!/bin/bash
# Arousal and valence prediction using bag-of-audio-words

wavfile=input.wav

#./SMILExtract -C "mfcc_energy.conf" -logfile "smile.log" -I $wavfile -instname $wavfile -csvoutput "LLD.csv" -l 1
./SMILExtract -C "mfcc_energy.conf" -logfile "smile.log" -I $wavfile -instname $wavfile -csvoutput "LLD.csv" -l 1

java -jar openXBOW.jar -i LLD.csv -attributes nt1111111111111 -o boaw.libsvm -a 10 -norm 1 -b book &>/dev/null
./predict boaw.libsvm modelArousal.svr arousal.txt &>/dev/null
./predict boaw.libsvm modelValence.svr valence.txt &>/dev/null

cat arousal.txt

cat valence.txt
