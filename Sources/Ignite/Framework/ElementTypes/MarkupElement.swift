//
// HTMLRenderable.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

/// A protocol that defines the common behavior between all HTML types.
/// - Warning: Do not conform to this type directly.
@MainActor
public protocol MarkupElement: Sendable {
    /// The standard set of control attributes for HTML elements.
    var attributes: CoreAttributes { get set }

    /// Converts this element and its children into HTML markup.
    /// - Returns: A string containing the HTML markup
    func markup() -> Markup
}

public extension MarkupElement {
    /// Converts this element and its children into an HTML string with attributes.
    /// - Returns: A string containing the HTML markup
    public func markupString() -> String {
        markup().string
    }

    /// The publishing context of this site.
    public var publishingContext: PublishingContext {
        PublishingContext.shared
    }

    public func `is`(_ elementType: any MarkupElement.Type) -> Bool {
        switch self {
        case let element as any HTML:
            element.isType(elementType)
        case let element as any InlineElement:
            element.isType(elementType)
        default: false
        }
    }

    public func `as`<T: MarkupElement>(_ elementType: T.Type) -> T? {
        switch self {
        case let element as any HTML:
            element.asType(elementType)
        case let element as any InlineElement:
            element.asType(elementType)
        default: nil
        }
    }
}

public extension HTML {
    /// Whether this element represents a specific type.
    public func isType(_ elementType: any MarkupElement.Type) -> Bool {
        if let anyHTML = body as? AnyHTML {
            type(of: anyHTML.wrapped) == elementType
        } else {
            type(of: body) == elementType
        }
    }

    /// The underlying content, conditionally cast to the specified type.
    public func asType<T: MarkupElement>(_ elementType: T.Type) -> T? {
        if let anyHTML = body as? AnyHTML, let element = anyHTML.attributedContent as? T {
            element
        } else if let element = body as? T {
            element
        } else {
            nil
        }
    }
}

public extension InlineElement {
    /// The underlying content, conditionally cast to the specified type.
    func asType<T: MarkupElement>(_ elementType: T.Type) -> T? {
        if let anyHTML = body as? AnyInlineElement, let element = anyHTML.attributedContent as? T {
            element
        } else if let element = body as? T {
            element
        } else {
            nil
        }
    }

    /// Whether this element represents a specific type.
    public func isType(_ elementType: any MarkupElement.Type) -> Bool {
        if let anyHTML = body as? AnyInlineElement {
            type(of: anyHTML.wrapped) == elementType
        } else {
            type(of: body) == elementType
        }
    }
}
