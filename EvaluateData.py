import csv
import pandas
import scipy.stats

class TimeDataSet:
    sortTypes = ["BubbleSort", "InsertionSort", "MergeSort", "QuickSort", "SelectionSort"]
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

outputFile.write("DESCRIPTIONS OF SPEEDS FOR EACH RUN CONFIGURATION\n")
for configuration in runConfigurations:
    for sortType in TimeDataSet.sortTypes:
        outputFile.write("Description of " + sortType + " in " + configuration + ":\n" + repr(pandas.Series(dataSets[configuration].sortTimes[sortType]).describe()) + "\n")

outputFile.write("\n\nCOMPARISON BETWEEN RUN CONFIGURATIONS UNDER EACH SORT\n")
requiredPValueForSignificance = 0.01
evaluatedConfigurationPairs = []
significantConfigurations = []
for configuration1 in runConfigurations:
    for configuration2 in runConfigurations:
        configurationPair = set([configuration1, configuration2])
        if configuration1 == configuration2 or configurationPair in evaluatedConfigurationPairs:
            continue
        for sortType in TimeDataSet.sortTypes:
            testStatistic, pValue = scipy.stats.ttest_ind(dataSets[configuration1].sortTimes[sortType], dataSets[configuration2].sortTimes[sortType])
            evaluatedConfigurationPairs.append(configurationPair)
            outputFile.write("p-Value for " + sortType + " in " + configuration1 + " vs " + configuration2 + ": " + repr(pValue) + "\n")
            if pValue < requiredPValueForSignificance:
                significantConfigurations.append(sortType + " in " + configuration1 + " vs " + configuration2)

outputFile.write("\n\nSIGNIFICANT SPEED DIFFERENCES\n")
for configuration in significantConfigurations:
    outputFile.write(configuration + "\n")
