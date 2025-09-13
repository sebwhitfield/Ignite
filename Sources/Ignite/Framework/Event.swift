//
// Event.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// One event that can trigger a series of actions, such as
/// an onClick event hiding an element on the page.
public struct Event: Sendable, Hashable, Comparable {
    public var name: String
    public var actions: [any Action]

    public static func == (lhs: Event, rhs: Event) -> Bool {
        rhs.name == lhs.name &&
        rhs.actions.map { $0.compile() } == lhs.actions.map { $0.compile() }
    }

    public static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.name < rhs.name
    }

    public init(_ type: EventType, actions: [any Action]) {
        self.name = type.rawValue
        self.actions = actions
    }

    public init(name: String, actions: [any Action]) {
        self.name = name
        self.actions = actions
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(actions.map { $0.compile() })
    }
}
