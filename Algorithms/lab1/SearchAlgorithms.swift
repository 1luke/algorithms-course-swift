//
//  SearchAlgorithms.swift
//  Algorithms
//
//  Created by Luke on 23/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// Linear search

@discardableResult
public func linearSearchIndex<Item: Equatable>(of item: Item, in array: [Item]) -> Int? {
    for (index, element) in array.enumerated()
        where item == element {
            return index
    }
    return nil
}

// Binary search

func binarySearchIndex<Item: Comparable>(of item: Item, in array: [Item], range r: Range<Int>? = nil) -> Int? {
    let range = r ?? 0..<array.count

    guard range.lowerBound < range.upperBound else {
        return nil // item not in the array
    }

    // Mid index to split the array.
    let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2

    if array[midIndex] > item {
        return binarySearchIndex(of: item, in: array, range: range.lowerBound ..< midIndex)
    } else if array[midIndex] < item {
        return binarySearchIndex(of: item, in: array, range: midIndex + 1 ..< range.upperBound)
    } else {
        return midIndex
    }
}
