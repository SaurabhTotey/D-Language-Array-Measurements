import csv
import scipy

class TimeDataSet:
    sortTypes = ["bubbleSort", "insertionSort", "mergeSort", "selectionSort"]
    def __init__(self, fileName):
        reader = csv.DictReader(fileName, fieldnames=self.sortTypes)
        self.numberOfRows = sum(1 for row in reader)
        self.sortTimes = {}
        for sortType in self.sortTypes:
            self.sortTimes[sortType] = [row[sortType] for row in reader]

dynamicData = TimeDataSet("data/Dynamic.csv")
staticData = TimeDataSet("data/Static.csv")
memoryWasteDynamicData = TimeDataSet("data/MemoryWasteDynamic.csv")
memoryWasteStaticData = TimeDataSet("data/MemoryWasteStatic.csv")
