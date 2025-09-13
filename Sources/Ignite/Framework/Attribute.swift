//
// Attribute.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// A simple key-value pair of strings that is able to store custom attributes.
public struct Attribute: Hashable, Equatable, Sendable, Comparable, CustomStringConvertible {
    /// The attribute's name, e.g. "target" or "rel".
    public var name: String

    /// The attribute's value, e.g. "myFrame" or "stylesheet".
    public var value: String?

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    public init(_ name: String) {
        self.name = name
        self.value = nil
    }

    public var description: String {
        if let value {
            "\(name)=\"\(value)\""
        } else {
            name
        }
    }

    public static func < (lhs: Attribute, rhs: Attribute) -> Bool {
        lhs.description < rhs.description
    }
}
