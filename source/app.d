/**
 * Handles actually collecting the data and writing it out to file
 */
module App;

import std.conv;
import std.datetime.stopwatch;
import std.file;
import std.random;
import std.traits;
import core.thread;
import MemoryWaster;
import Sorter;

/**
 * An enumeration of configurations of what will be measured
 */
enum RunConfigurations {
    STATIC, DYNAMIC, STATIC_WITH_MEMORY_WASTE, DYNAMIC_WITH_MEMORY_WASTE
}

//CONSTANTS
enum wasteAmount = 8;
enum arraySize = 1000;
StopWatch timer = StopWatch(AutoStart.no);

/**
 * Entry point of the program
 */
void main() {
    RunConfigurations[] runOrder = [EnumMembers!RunConfigurations];
    runOrder.randomShuffle();
    foreach (runConfig; runOrder) {
        bool isRunning = true;
        string filePath = "data/";
        if (runConfig == RunConfigurations.STATIC_WITH_MEMORY_WASTE || runConfig == RunConfigurations.DYNAMIC_WITH_MEMORY_WASTE) {
            new Thread({ wasteMemory!wasteAmount(5, isRunning); }).start();
            filePath ~= "MemoryWaste";
        }
        if (runConfig == RunConfigurations.STATIC || runConfig == RunConfigurations.STATIC_WITH_MEMORY_WASTE) {
            filePath ~= "Static.csv";
            double[arraySize] arrayToBubbleSort;
            double[arraySize] arrayToInsertionSort;
            double[arraySize] arrayToMergeSort;
            double[arraySize] arrayToSelectionSort;
            foreach (i; 0..arraySize) {
                arrayToBubbleSort[i] = uniform(0.0, 1.0);
                arrayToBubbleSort[i] = uniform(0.0, 1.0);
                arrayToMergeSort[i] = uniform(0.0, 1.0);
                arrayToSelectionSort[i] = uniform(0.0, 1.0);
            }
            timer.start();
            timer.reset();
            bubbleSort(arrayToBubbleSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ ",");
            timer.reset();
            insertionSort(arrayToInsertionSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ ",");
            timer.reset();
            mergeSort(arrayToMergeSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ ",");
            timer.reset();
            selectionSort(arrayToSelectionSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ "\n");
            timer.stop();
        } else {
            filePath ~= "Dynamic.csv";
            double[] arrayToBubbleSort;
            double[] arrayToInsertionSort;
            double[] arrayToMergeSort;
            double[] arrayToSelectionSort;
            foreach (i; 0..arraySize) {
                arrayToBubbleSort ~= uniform(0.0, 1.0);
                arrayToBubbleSort ~= uniform(0.0, 1.0);
                arrayToMergeSort ~= uniform(0.0, 1.0);
                arrayToSelectionSort ~= uniform(0.0, 1.0);
            }
            timer.start();
            timer.reset();
            bubbleSort(arrayToBubbleSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ ",");
            timer.reset();
            insertionSort(arrayToInsertionSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ ",");
            timer.reset();
            mergeSort(arrayToMergeSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ ",");
            timer.reset();
            selectionSort(arrayToSelectionSort);
            append(filePath, timer.peek.total!"usecs".to!string ~ "\n");
            timer.stop();
        }
        isRunning = false;
    }
}
