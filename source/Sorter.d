module Sorter;

/**
 * Swaps elements in array at firstIndex and secondIndex in place
 */
void swap(T)(ref T array, ulong firstIndex, ulong secondIndex) {
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
}

/**
 * A function that bubblesorts the given array in place
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
 * Tests for the bubbleSort method
 */
unittest {
    int[] a1 = [3, 4, 2, 5, 0, 6, 1];
    bubbleSort(a1);
    assert(a1 == [0, 1, 2, 3, 4, 5, 6]);
    int[4] a2 = [3, 9, 4, 7];
    bubbleSort(a2);
    assert(a2 == [3, 4, 7, 9]);
}