//
//  TCFilterApplier.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

/// A protocol that defines the requirements for a filter applier.
public protocol TCFilterApplier {
    /// The associated type that represents the regex filter.
    associatedtype RegexFilter: RegexComponent
    
    /// The regex pattern used for filtering.
    var regex: RegexFilter { get }
    
    /// Applies the filter to the input string.
    ///
    /// - Parameter input: The string to be filtered.
    /// - Returns: The filtered string.
    func replace(_ input: String) -> String
}

extension TCFilterApplier {
    public func replace(_ input: String) -> String {
        input.replacing(regex, with: "")
    }
}
