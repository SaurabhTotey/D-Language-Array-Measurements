module MemoryWaster;

import core.thread;

/**
 * A function that wastes wasteAmount of bytes, and does so every sleepTime milliseconds
 */
void wasteMemory(int wasteAmount)(ulong sleepTime) {
    byte[wasteAmount] makeAllocation() {
        byte[wasteAmount] wastedSpace;
        return wastedSpace;
    }
    immutable timeStep = msecs(sleepTime);
    for(;;) {
        makeAllocation();
        Thread.sleep(timeStep);
    }
}
