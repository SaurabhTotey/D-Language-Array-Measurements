module App;

import std.stdio;
import core.thread;
import MemoryWaster;

/**
 * Entry point of the program
 */
void main() {
    writeln("Hello World!");
    __gshared bool isRunning = true;
    new Thread({
        wasteMemory!5(500, isRunning);
    }).start();
    Thread.sleep(msecs(5000));
    isRunning = false;
}
