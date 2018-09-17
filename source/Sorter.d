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
 * A function that mergeSorts the given array in place
 */
void mergeSort(T)(ref T array) {
    void merge(ref T array, ulong leftIndex, ulong middleIndex, ulong rightIndex) {
        auto leftArray = array[leftIndex .. middleIndex + 1].dup;
        auto rightArray = array[middleIndex + 1 .. rightIndex + 1].dup;
        ulong i = 0;
        ulong j = 0;
        ulong k = leftIndex;
        while (i < leftArray.length && j < rightArray.length) {
            if (leftArray[i] <= rightArray[j]) {
                array[k] = leftArray[i];
                i++;
            } else {
                array[k] = rightArray[j];
                j++;
            }
            k++;
        }
        while (i < leftArray.length) {
            array[k] = leftArray[i];
            i++;
            k++;
        }
        while (j < rightArray.length) {
            array[k] = rightArray[j];
            j++;
            k++;
        }
    }
    void sort(ref T array, ulong leftIndex, ulong rightIndex) {
        if (leftIndex >= rightIndex) {
            return;
        }
        ulong middleIndex = (leftIndex + rightIndex) / 2;
        sort(array, leftIndex, middleIndex);
        sort(array, middleIndex + 1, rightIndex);
        merge(array, leftIndex, middleIndex, rightIndex);
    }
    sort(array, 0, array.length - 1);
}

/**
 * A function that quickSorts the given array in place
 * Default pivot is the middle element of the array
 */
void quickSort(T)(ref T array) {
    void sort(ref T array, ulong lowerIndex, ulong higherIndex) {
        ulong i = lowerIndex;
        ulong j = higherIndex;
        ulong pivot = array[(i + j) / 2];
        while (i <= j) {
            while (array[i] < pivot) {
                i++;
            }
            while (array[j] > pivot && j != 0) {
                j--;
            }
            if (i <= j) {
                swap(array, i, j);
                i++;
                if (j != 0) {
                    j--;
                }
            }
        }
        if (lowerIndex < j) {
            sort(array, lowerIndex, j);
        }
        if (higherIndex > i) {
            sort(array, i, higherIndex);
        }
    }
    sort(array, 0, array.length - 1);
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
