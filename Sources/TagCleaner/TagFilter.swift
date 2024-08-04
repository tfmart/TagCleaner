//
//  TagFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


@propertyWrapper
public struct TagFilter {
    public var wrappedValue: TCFilter
    
    public init(_ filter: TCFilter) {
        self.wrappedValue = filter
    }
}
