//
//  HashTable.swift
//  Algorithms
//
//  Created by Luke on 23/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

// MARK: Item

/// The key-value pair item
public class HashItem<Key: Hashable, Value> {
    public var key: Key
    public var value: Value?

    public init(key: Key, value: Value?) {
        self.key = key
        self.value = value
    }
}

/// Hash table (uses separate chain hash)
public struct HashTable<Key: Hashable, Value>: CustomStringConvertible {
    public typealias Bucket = [HashItem<Key, Value>]

    public private(set) var buckets: [Bucket]

    init(capacity: Int) {
        buckets = Array<Bucket>(repeatElement([], count: nextPrime(after: capacity)))
    }

    public func hashIndex(of key: Key) -> Int {
        return abs(key.hashValue) % buckets.count // SipHash
    }

    public func value(for key: Key) -> Value? {
        let bucket = buckets[hashIndex(of: key)]
        return bucket.first { $0.key == key }?.value
    }

    @discardableResult
    public mutating func update(value newValue: Value?, for key: Key) -> Value? {
        let hashIndex: Int = self.hashIndex(of: key)
        for (index, hashItem) in buckets[hashIndex].enumerated()
            where hashItem.key == key {
                let oldValue = hashItem.value
                buckets[hashIndex][index].value = newValue
                return oldValue
        }
        buckets[hashIndex].append(HashItem(key: key, value: newValue))
        return nil
    }

    @discardableResult
    mutating func removeValue(for key: Key) -> Value? {
        let hashIndex: Int = self.hashIndex(of: key)
        for (index, hashItem) in buckets[hashIndex].enumerated()
            where hashItem.key == key {
                buckets[hashIndex].remove(at: index)
                return hashItem.value
        }
        return nil
    }

    // MARK: Subscript

    public subscript(key: Key) -> Value? {
        get { return value(for: key) }
        set { update(value: newValue, for: key) }
    }

    // MARK: CustomStringConvertible

    public var description: String {
        var description = ""
        for (hash, bucket) in buckets.enumerated() {
            bucket.isEmpty ? () : description.append("(hash: \(hash))\n")
            for item in bucket {
                description.append("Key: \(item.key), Value: \(describe(item.value))\n")
            }
            bucket.isEmpty ? () : description.append("\n")
        }
        return description
    }
}

public let describe: (Any?) -> String = {
    $0 == nil ? "noValue" : "\($0!)"
}
