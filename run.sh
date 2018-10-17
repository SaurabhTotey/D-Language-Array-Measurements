#!/bin/bash
dub build -b=ddox
numberOfRuns=1000
for ((i=1;i<numberOfRuns;i++))
do
    echo "Doing Run #$i"
    dub run
done
echo "Data generation is done! Now evaluating data!"
python3 EvaluateData.py