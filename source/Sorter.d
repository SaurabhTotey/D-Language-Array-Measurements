/**
 * Templates are used for sorter methods because int[] and int[size] are different types
 * Templates allow for having the same methods for different tyeps
 * Using a template and not separate methods incurs no runtime costs because template parameters are evaluated at compiletime
 * All arguments are ref because they take arrays in by reference and not by value
 * Taking arrays in by reference allows for in-place sorting and swapping
 */
module Sorter;

/**
 * Swaps elements in array at firstIndex and secondIndex in place
 */
void swap(T)(ref T array, ulong firstIndex, ulong secondIndex) {
    if (firstIndex == secondIndex) {
        return;
    }
    array[firstIndex] += array[secondIndex];
    array[secondIndex] = array[firstIndex] - array[secondIndex];
    array[firstIndex] = array[firstIndex] - array[secondIndex];
}

/**
 * Tests for the swap method
 */
unittest {
    int[] a1 = [1, 2, 3, 4, 5];
    swap(a1, 0, 1);
    assert(a1 == [2, 1, 3, 4, 5]);
    swap(a1, 3, 1);
    assert(a1 == [2, 4, 3, 1, 5]);
    int[4] a2 = [1, 2, 3, 4];
    swap(a2, 0, 3);
    assert(a2 == [4, 2, 3, 1]);
    swap(a2, 1, 0);
    assert(a2 == [2, 4, 3, 1]);
    swap(a2, 2, 2);
    assert(a2 == [2, 4, 3, 1]);
}

/**
 * A function that selectionSorts the given array in place
 */
void selectionSort(T)(ref T array) {
    foreach (i; 0 .. array.length - 1) {
        auto indexOfSmallest = i;
        foreach (j; i .. array.length) {
            if (array[j] < array[indexOfSmallest]) {
                indexOfSmallest = j;
            }
        }
        swap(array, i, indexOfSmallest);
    }
}

/**
 * A function that insertionSorts the given array in place
 */
void insertionSort(T)(ref T array) {
    foreach (i; 1 .. array.length) {
        auto key = array[i];
        auto j = i - 1;
        while (j < array.length && array[j] > key) {
            array[j + 1] = array[j];
            j--;
        }
        array[j + 1] = key;
    }
}

/**
 * A function that bubbleSorts the given array in place
 */
void bubbleSort(T)(ref T array) {
    foreach (i; 0 .. array.length) {
        foreach (j; 0 .. array.length - i - 1) {
            if (array[j] > array[j + 1]) {
                swap(array, j, j + 1);
            }
        }
    }
}

/**
 * Tests for all of the sort methods
 */
unittest {
    import std.algorithm;
    import std.conv;
    import std.stdio;

    /**
     * Tests a sort method given the name of the sort function
     */
    void testSort(string sortName)() {
        writeln("Testing " ~ sortName ~ " with dynamic array.");
        int[] a1 = [3, 4, 2, 5, 0, 6, 1];
        mixin(sortName ~ "(a1);");
        assert(a1 == [0, 1, 2, 3, 4, 5, 6], a1.to!string ~ " is not sorted!");
        writeln("Testing " ~ sortName ~ " with static array.");
        int[4] a2 = [3, 9, 4, 7];
        mixin(sortName ~ "(a2);");
        assert(a2 == [3, 4, 7, 9], a2.to!string ~ " is not sorted!");
    }

    /**
     * Calls testSort on all functions in this module that have 'Sort' in their names
     */
    foreach (sortFunction; __traits(allMembers, Sorter)) {
        static if (sortFunction.canFind("Sort")) {
            testSort!sortFunction;
        }
    }
}
