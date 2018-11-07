//
//  main.swift
//  Algorithms
//
//  Created by Luke on 23/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// MARK: Lab1

print("-----Integer search")
testSearches(Int.self, arraySize: 55_000)

print("\n-----String search")
testSearches(String.self, arraySize: 55_000)

// MARK: Lab2

print("\n")
testHashTable()

// MARK: Lab3

print("\n")
testSorting()
