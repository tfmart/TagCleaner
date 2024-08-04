//
//  TagCleaner.swift
//
//
//  Created by Tomas Martins on 04/12/23.
//

import Foundation
import RegexBuilder

public struct TagCleaner {
    @TagFilter(.cleanExplicit) public var cleanExplicit
    @TagFilter(.featuredArtists) public var featuredArtists
    @TagFilter(.remastered) public var remastered
    @TagFilter(.reissue) public var reissue
    @TagFilter(.remix) public var remix
    @TagFilter(.single) public var single
    @TagFilter(.ep) public var ep
    @TagFilter(.bonusTrack) public var bonusTrack
    @TagFilter(.live) public var live
    @TagFilter(.parody) public var parody
    @TagFilter(.version) public var version
    @TagFilter(.youtube) public var youtube
    @TagFilter(.additionalArtists) public var additionalArtists
    
    private let regex = TCRegex()
    
    public init() {}
    
    /// Applies the specified filters to the input string.
    /// - Parameters:
    ///   - input: The string to be filtered.
    ///   - filters: The filters to apply. If not specified, all filters will be applied.
    /// - Returns: The filtered string.
    public func apply(_ input: String, filters: TCFilter...) -> String {
        let filtersToApply = filters.isEmpty ? TCFilter.allCases : filters
        var result = input
        
        for filter in filtersToApply {
            for expression in filter.expressions {
                result = result.replacing(expression, with: "")
            }
        }
        
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Creates a custom filter using the provided filter builder.
    /// - Parameter filters: A closure that builds the custom filter using the TagFilterBuilder.
    /// - Returns: An array of TCFilter to be used with the `apply(_:filters:)` method.
    public static func createCustomFilter(@TagFilterBuilder filters: () -> [TCFilter]) -> [TCFilter] {
        filters()
    }
}
