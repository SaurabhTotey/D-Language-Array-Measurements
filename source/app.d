/**
 * Handles actually collecting the data and writing it out to file
 */
module App;

import std.random;
import std.stdio;
import std.traits;
import core.thread;
import MemoryWaster;

/**
 * An enumeration of configurations of what will be measured
 */
enum RunConfigurations {
    STATIC, DYNAMIC, STATIC_WITH_MEMORY_WASTE, DYNAMIC_WITH_MEMORY_WASTE
}

//CONSTANTS
enum wasteAmount = 8;

/**
 * Entry point of the program
 */
void main() {
    RunConfigurations[] runOrder = [EnumMembers!RunConfigurations];
    runOrder.randomShuffle();
    foreach (runConfig; runOrder) {
        bool isRunning = true;
        if (runConfig == RunConfigurations.STATIC_WITH_MEMORY_WASTE || runConfig == RunConfigurations.DYNAMIC_WITH_MEMORY_WASTE) {
            new Thread({ wasteMemory!wasteAmount(5, isRunning); }).start();
        }
        if (runConfig == RunConfigurations.STATIC || runConfig == RunConfigurations.STATIC_WITH_MEMORY_WASTE) {
            //TODO: time and record sorts for static arrays
        } else {
            //TODO: time and record sorts for dynamic arrays
        }
        isRunning = false;
    }
}
