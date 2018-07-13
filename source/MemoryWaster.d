/**
 * Handles background memory consumption
 */
module MemoryWaster;

import core.thread;

/**
 * A function that wastes wasteAmount of bytes, and does so every sleepTime milliseconds
 * Also takes a reference to a boolean
 * Function will continue to execute or waste memory until continueWastingMemory is false
 */
void wasteMemory(int wasteAmount)(ulong sleepTime, ref bool continueWastingMemory) {
    byte[wasteAmount] makeAllocation() {
        byte[wasteAmount] wastedSpace;
        return wastedSpace;
    }
    immutable timeStep = msecs(sleepTime);
    while(continueWastingMemory) {
        makeAllocation();
        Thread.sleep(timeStep);
    }
}
