//
//  SortAlgorithms.swift
//  Algorithms
//
//  Created by Luke on 23/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// MARK: Insertion sort

func insertionSort<T: Comparable>(array unsorted: [T]) -> [T] {
    guard unsorted.count > 1 else { return unsorted }

    var sorting = unsorted

    for index in 1..<sorting.count {
        var correctIndex = index
        let item = sorting[correctIndex]

        while correctIndex > 0 && item < sorting[correctIndex - 1] {
            sorting[correctIndex] = sorting[correctIndex - 1]
            correctIndex -= 1
        }

        sorting[correctIndex] = item
    }

    return sorting
}

// MARK: Bubble sort

func bubbleSort<T: Comparable>(array: inout [T]) {
    let lastIndex = array.count - 1
    for outerIndex in 0..<lastIndex {
        for innerIndex in 0..<(lastIndex - outerIndex)
            where array[innerIndex] > array[innerIndex + 1] {
            let temp = array[innerIndex]
            array[innerIndex] = array[innerIndex + 1]
            array[innerIndex + 1] = temp
        }
    }
}
