//
//  Lab2.swift
//  Algorithms
//
//  Created by Luke on 23/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// MARK: Test (java impl. by Jarkko translation)

func testHashTable() {

    /// non-repeating random generator (java SecureRandom)
    let randoms: [Int] = []
    let secureRandom: (Int) -> Int = { max in
        var number: Int
        repeat {
            number = Int.random(in: 0..<max)
        } while randoms.contains(number)
        return number
    }

    // create random strings collection
    let numberOfStrings: Int = 30
    let stringLength = 32
    let stringArray: [String] = (0..<numberOfStrings).map { _ in String.random(length: stringLength) }

    // store it in dictionary
    var hashTable = HashTable<String, String>(capacity: stringArray.count)
    for string in stringArray {
        hashTable.update(value: string, for: string)
    }

    // print the dictionary
    print(hashTable.description)

    /*try to search half of the strings from the dictionary*/
    print("\n\nHalf of the searches should succeed, half fail:")

    var result: String? = nil
    var search_element: String = ""
    var j = 0
    for i in 0..<numberOfStrings/2 {
        j = secureRandom(numberOfStrings - 1)
        search_element = stringArray[j]

        // quater of the strings should not be found
        if i > (numberOfStrings / 4) { search_element += "#" }
        result = hashTable.value(for: search_element)
        //System.out.format("%1$2d: element %2$s (%3$02d), search result %4$s\n", i, search_element, j, result!=null ? "F" : "N");
        print("\(i), \(search_element), \(j), \(String(describing: result)) ")
    }

    /* then delete first and the middle element from the dictionary */
    hashTable.removeValue(for: stringArray[0])
    hashTable.removeValue(for: stringArray[numberOfStrings / 2 - 1])

    //try to search again strings from the dictionary, first and the last should not be found
    //System.out.println("\n\nFirst and last search should fail, other should succeed:");
    print("\n\nFirst and last search should fail, other should succeed:")

    //for (int i = 0; i < N/2; i++) {
    for i in 0..<numberOfStrings/2 {
        j = i
        search_element = stringArray[i]
        result = hashTable.value(for: search_element)
        print("\(search_element), \(j), Found: \(result != nil)")
    }
}
