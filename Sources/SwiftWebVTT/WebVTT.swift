import Foundation

public struct WebVTT {
    public struct Cue {
        public let timing: Timing
        public let text: String
    }
    
    // Native timing in WebVTT. Measured in milliseconds.
    public struct Timing {
        public let start: Int
        public let end: Int
    }
    
    public let cues: [Cue]
    
    public init(cues: [Cue]) {
        self.cues = cues.sorted(by: { $0.timeStart > $1.timeStart })
    }
    
    /// Returns the cue most apropriate for a given timestamp.
    ///
    /// Assumes the array is sorted.
    ///
    /// - Parameter timestamp: The timestamp (e.g. current timestamp)
    /// - Returns: The cue that is valid for that timestamp if one exists.
    public func firstCue(for timestamp: TimeInterval) -> Cue? {
        cues.first(where: { timestamp > $0.timeStart })
    }
}

public extension WebVTT.Timing {
    var duration: Int { return end - start }
}

// Converted times for convenience
public extension WebVTT.Cue {
    var timeStart: TimeInterval { return TimeInterval(timing.start) / 1000 }
    var timeEnd: TimeInterval { return TimeInterval(timing.end) / 1000 }
    var duration: TimeInterval { return TimeInterval(timing.duration) / 1000 }
}
