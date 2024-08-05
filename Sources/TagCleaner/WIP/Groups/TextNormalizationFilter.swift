//
//  TextNormalizationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct TextNormalizationFilter: TCFilterApplierGroup {
    var regex: String {
        "textNormalization"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case htmlEntities
        case zeroWidthCharacters
        case nonBreakingSpaces
        case smartQuotes
        case whitespace
        case multipleSpaces
        
        var regex: String {
            switch self {
            case .htmlEntities:
                "htmlEntities"
            case .zeroWidthCharacters:
                "zeroWidthCharacters"
            case .nonBreakingSpaces:
                "nonBreakingSpaces"
            case .smartQuotes:
                "smartQuotes"
            case .whitespace:
                "whitespace"
            case .multipleSpaces:
                "multipleSpaces"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var htmlEntities: Subgroups = .htmlEntities
    static var zeroWidthCharacters: Subgroups = .zeroWidthCharacters
    static var nonBreakingSpaces: Subgroups = .nonBreakingSpaces
    static var smartQuotes: Subgroups = .smartQuotes
    static var whitespace: Subgroups = .whitespace
    static var multipleSpaces: Subgroups = .multipleSpaces
}