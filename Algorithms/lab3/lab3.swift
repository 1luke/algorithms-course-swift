//
//  lab3.swift
//  Algorithms
//
//  Created by Luke on 06/11/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// MARK: Test sort algorithms

func testSorting() {
    let randomArray: [Int] = (0..<100).map { _ in Int.random(in: 0..<500) }
    var sorted: [Int] = []
    print("Unsorted: ", randomArray)

    var stopwatch = Stopwatch()
    Stopwatch.frequency = 1000
    Stopwatch.outliers = 500

    try! stopwatch.measure {
        sorted = insertionSort(array: randomArray)
    }

    print("\n\nInsertion sort:      ", stopwatch)

    guard sorted == randomArray.sorted() else {
        fatalError("Sort algorithm failed")
    }

    // Test buble sort

    sorted = randomArray
    try! stopwatch.measure {
        bubbleSort(array: &sorted)
    }

    print("Bubble sort:         ", stopwatch)

    guard sorted == randomArray.sorted() else {
        fatalError("Sort algorithm failed")
    }
}
