//
//  Stopwatch.swift
//  Algorithms
//
//  Created by Luke on 23/10/2018.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation

public typealias Nanoseconds = UInt64

public struct Stopwatch: CustomStringConvertible {

    enum Clock {
        case neverUsed
        case running(started: DispatchTime)
        case completed(result: Nanoseconds)

        var result: Nanoseconds? {
            guard case let .completed(result) = self else { return nil }
            return result
        }
    }

    private(set) var clock: Clock = .neverUsed

    public mutating func start() throws {
        if case .running(_) = clock {
            throw "Error: " + description
        }
        clock = .running(started: DispatchTime.now())
    }

    public mutating func stop() throws {
        let stoppage = DispatchTime.now().uptimeNanoseconds
        guard case let .running(started) = clock else {
            throw "Error: start first! Current state: " + description
        }
        clock = .completed(result: stoppage - started.uptimeNanoseconds)
    }

    public static var frequency: Int = 24
    public static var outliers: Int = 16

    public mutating func measure(
        frequency samples: Int = frequency,
        outliers: Int = outliers,
        preTest: () -> Void =  {},
        postTest: () -> Void = {},
        testBlock block: () -> Void) throws {

        guard samples > 0 && outliers >= 0 else {
            throw "Invalid frequency and/or outliers!"
        }

        var measurements: [Nanoseconds] = []
        for _ in 0..<(samples + outliers) {
            preTest()
            try start()
            block()
            try stop()
            postTest()
            measurements.append(clock.result!)
        }
        measurements.sort()
        measurements.removeSubrange(samples..<measurements.count) // remove outliers
        assert(measurements.count == samples, "Fix the above range!")

        let avarage = measurements.reduce(0, +) / UInt64(measurements.count)
        clock = .completed(result: avarage)
    }

    // MARK: CustomStringConvertible

    public var description: String {
        switch clock {
        case .neverUsed: return "Stopwatch never started"
        case .running(started: let time): return "Stopwatch is running since: \(time)"
        case .completed(result: let nanoseconds): return "\(milliseconds(fromNano: nanoseconds)) ms"
        }
    }
}

func milliseconds(fromNano nano: Nanoseconds) -> TimeInterval {
    return TimeInterval(nano) / 1_000_000
}

/// Support throwing string as error
extension String: Error {
}
