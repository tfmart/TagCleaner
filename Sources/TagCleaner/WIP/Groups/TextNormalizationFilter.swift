//
//  TextNormalizationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct TextNormalizationFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.htmlEntities.regex
            Subgroups.zeroWidthCharacters.regex
            Subgroups.nonBreakingSpaces.regex
            Subgroups.smartQuotes.regex
            Subgroups.whitespace.regex
            Subgroups.multipleSpaces.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case htmlEntities
        case zeroWidthCharacters
        case nonBreakingSpaces
        case smartQuotes
        case whitespace
        case multipleSpaces
        
        var regex: some RegexComponent {
            switch self {
            case .htmlEntities:
                Regex {
                    "&"
                    OneOrMore(.word)
                    ";"
                }
            case .zeroWidthCharacters:
                Regex {
                    ChoiceOf {
                        "\u{200B}"
                        "\u{200C}"
                        "\u{200D}"
                        "\u{FEFF}"
                    }
                }
            case .nonBreakingSpaces:
                Regex {
                    "\u{00A0}"
                }
            case .smartQuotes:
                Regex {
                    ChoiceOf {
                        "\u{2018}"
                        "\u{2019}"
                        "\u{201C}"
                        "\u{201D}"
                    }
                }
            case .whitespace:
                Regex {
                    OneOrMore(.whitespace)
                }
            case .multipleSpaces:
                Regex {
                    Repeat(.whitespace, count: 2)
                }
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    static var htmlEntities: Subgroups = .htmlEntities
    static var zeroWidthCharacters: Subgroups = .zeroWidthCharacters
    static var nonBreakingSpaces: Subgroups = .nonBreakingSpaces
    static var smartQuotes: Subgroups = .smartQuotes
    static var whitespace: Subgroups = .whitespace
    static var multipleSpaces: Subgroups = .multipleSpaces
}
