//
// Declaration.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// A simple property-value pair of strings that is able to store inline styles
public struct InlineStyle: Hashable, Equatable, Sendable, Comparable, CustomStringConvertible {
    /// The property, e.g. `\.color`.
    public var property: String

    /// The declaration's value, e.g. "blue".
    public var value: String

    public init(_ property: Property, value: String) {
        self.property = property.rawValue
        self.value = value
    }

    public init(_ property: String, value: String) {
        self.property = property
        self.value = value
    }

    /// The full declaration, e.g. "color: blue""
    public var description: String {
        property + ": " + value
    }

    public static func < (lhs: InlineStyle, rhs: InlineStyle) -> Bool {
        lhs.description < rhs.description
    }

    public func important(_ isImportant: Bool = true) -> InlineStyle {
        if isImportant {
            InlineStyle(self.property, value: self.value + " !important")
        } else {
            self
        }
    }
}
