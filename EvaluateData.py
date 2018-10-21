import csv
import scipy.stats

class TimeDataSet:
    sortTypes = ["BubbleSort", "InsertionSort", "MergeSort", "SelectionSort"]
    def __init__(self, fileName):
        file = open(fileName)
        reader = csv.DictReader(file, fieldnames=self.sortTypes)
        self.sortTimes = {}
        for sortType in self.sortTypes:
            self.sortTimes[sortType] = [int(row[sortType]) for row in reader]
            file.seek(0)

runConfigurations = ["Dynamic", "Static", "MemoryWasteDynamic", "MemoryWasteStatic"]
dataSets = {}
for fileName in runConfigurations:
    dataSets[fileName] = TimeDataSet("data/" + fileName + ".csv")

outputFile = open("data/output.txt", "a")
evaluatedConfigurationPairs = []
for configuration1 in runConfigurations:
    for configuration2 in runConfigurations:
        configurationPair = set([configuration1, configuration2])
        if configuration1 == configuration2 or configurationPair in evaluatedConfigurationPairs:
            continue
        for sortType in TimeDataSet.sortTypes:
            testStatistic, pValue = scipy.stats.ttest_ind(dataSets[configuration1].sortTimes[sortType], dataSets[configuration2].sortTimes[sortType])
            evaluatedConfigurationPairs.append(configurationPair)
            outputFile.write("p-Value for " + sortType + " in " + configuration1 + " vs " + configuration2 + ": " + repr(pValue) + "\n")
