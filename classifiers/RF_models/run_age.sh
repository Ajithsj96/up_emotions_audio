#!/bin/bash
export CLASSPATH=$CLASSPATH:/path/to/weka-3-8-0/weka.jar
NEW_UUID=$(date | md5sum | awk '{ print substr( $0, 1, 10 ) }')'a.arff'
#NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)'.arff'
./SMILExtract -C IS09_emotion_age.conf -I $1 -l 0 -classlabel 0 -O $NEW_UUID
res=$(java weka.classifiers.functions.SMOreg -T  $NEW_UUID -l age_smoreg.model -classifications weka.classifiers.evaluation.output.prediction.PlainText | grep 1 | tr -s ' ' | sed -r 's/^ //g' | cut -d' ' -f3 |  cut -f1 -d".")
#| sed -r 's/^/class=/g'
printf '​{"PROCESSOR":"OpenSMILE","ORIGIN":"libsvm","TYPE":"regression","COMPONENT":"mysvmsink","VIDX":1,"VALUE":'$res',"PROB":[{"CONFIDENCE":1.00}]}​\n'
rm $NEW_UUID

