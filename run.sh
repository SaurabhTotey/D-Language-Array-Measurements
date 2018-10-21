#!/bin/bash
./deleteData.sh
dub build -b=ddox
numberOfRuns=1000
for ((i=0;i<numberOfRuns;i++))
do
    dub run -b=release
done
python3 EvaluateData.py