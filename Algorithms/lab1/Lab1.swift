//
//  Lab1.swift
//  Algorithms
//
//  Created by Luke on 23/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// MARK: Test searches

/// Makes conformer type testable with in `testSearches`
public protocol SearchTestable: Comparable {
    static func random(count: Int) -> [Self]
}

func testSearches<Item: SearchTestable>(_ Item: Item.Type, arraySize: Int) {
    let itemList = ItemList<Item>(count: arraySize)
    let array = itemList.sortedArray

    var stopwatch = Stopwatch()
    Stopwatch.frequency = 1000
    Stopwatch.outliers = 500

    var testIndex: Int!
    var resultIndex: Int?

    let setRandomTestIndex: () -> Void = {
        testIndex = Int.random(in: 0..<array.count)
    }

    let checkResult: () -> Void = {
        if let result = array[safe: resultIndex], result == array[safe: testIndex] {
            //print("Result: \(result) == \(array[testIndex])")
        } else {
            fatalError("Not found!")
        }
    }

    try! stopwatch.measure(preTest: setRandomTestIndex, postTest: checkResult) {
        resultIndex = itemList.linearSearch(array[testIndex])
    }
    print("Linear search: ", stopwatch)

    try! stopwatch.measure(preTest: setRandomTestIndex, postTest: checkResult) {
        resultIndex = itemList.binarySearch(array[testIndex])
    }
    print("Binary search: ", stopwatch)
}

// MARK: Test helpers

/// Wrapper for a sorted array of `Comparable`s + linear and binary search api
public class ItemList<Item: SearchTestable> {

    public let sortedArray: [Item]

    init(count: Int) {
        sortedArray = Item.random(count: count).sorted()
    }

    @discardableResult
    public func linearSearch(_ item: Item) -> Int? {
        return linearSearchIndex(of: item, in: sortedArray)
    }

    @discardableResult
    public func binarySearch(_ item: Item) -> Int? {
        return binarySearchIndex(of: item, in: sortedArray)
    }
}

extension Int: SearchTestable {
    public static func random(count: Int) -> [Int] {
        return (0..<count).map { _ in Int.random(in: 0..<Int.max) }
    }
}

extension String: SearchTestable {
    public static func random(count: Int) -> [String] {
        return (0..<count).map { _ in String.random(length: 32) }
    }
}
