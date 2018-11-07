//
//  Helpers.swift
//  Algorithms
//
//  Created by Luke on 30/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// MARK: Prime calculator (java impl. by Jarkko translation)

func nextPrime(after n: Int) -> Int {
    var prime: Int = 0
    var nextPrime: Int!

    // Check if this is a prime number
    for _ in 2..<n/2 where n % 2 == 0 {
        prime = 1
        break
    }

    guard prime == 1 else {
        return n
    }

    // Try to find next prime
    nextPrime = n
    prime = 1

    while prime != 0 {
        nextPrime += 1
        prime = 0

        for _ in 2..<nextPrime / 2 where nextPrime % 2 == 0 {
            prime = 1
            break
        }
    }

    return nextPrime
}

// sourced from https://gist.github.com/kharrison/2355182ac03b481921073c5cf6d77a73#file-country-swift-L31
func djb2Hash(_ string: String) -> Int {
    let unicodeScalars = string.unicodeScalars.map { $0.value }
    return unicodeScalars.reduce(5381) {
        ($0 << 5) &+ $0 &+ Int($1)
    }
}

extension String {
    static func random(length: Int) -> String {
        var result = ""
        (0..<length).forEach { _ in
            var character = UnicodeScalar("a").value
            character += arc4random_uniform(26) // alphabets
            result.append(Character(UnicodeScalar(character)!))
        }
        return result
    }
}

extension Collection {
    subscript (safe index: Index?) -> Element? {
        guard let index = index else { return nil }
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: Test

func elapsedNanoseconds(on block: () -> Void) -> Nanoseconds {
    let start = DispatchTime.now().uptimeNanoseconds
    block()
    let end = DispatchTime.now().uptimeNanoseconds
    return end - start
}

func measure(executionOf block: () -> Void, frequency: Int) -> TimeInterval {
    var measurments: [Nanoseconds] = []
    (0..<frequency).forEach { _ in
        measurments.append(elapsedNanoseconds(on: block))
    }
    return milliseconds(fromNano: measurments.reduce(0, +) / UInt64(measurments.count))
}
