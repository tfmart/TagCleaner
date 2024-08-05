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
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case htmlEntities
        case zeroWidthCharacters
        case nonBreakingSpaces
        case smartQuotes
        case whitespace
        case multipleSpaces
        
        public var regex: some RegexComponent {
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
        
        public func replace(_ input: String) -> String {
            switch self {
            case .htmlEntities:
                return input.replacingOccurrences(of: "&amp;", with: "&")
                    .replacingOccurrences(of: "&#039;", with: "'")
            case .nonBreakingSpaces:
                return input.replacingOccurrences(of: "\u{00A0}", with: " ")
            case .smartQuotes:
                return input.replacingOccurrences(of: "\u{201C}", with: "\"")
                    .replacingOccurrences(of: "\u{201D}", with: "\"")
                    .replacingOccurrences(of: "\u{2018}", with: "'")
                    .replacingOccurrences(of: "\u{2019}", with: "'")
            default:
                return input.replacing(regex, with: "")
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let htmlEntities: Subgroups = .htmlEntities
    public let zeroWidthCharacters: Subgroups = .zeroWidthCharacters
    public let nonBreakingSpaces: Subgroups = .nonBreakingSpaces
    public let smartQuotes: Subgroups = .smartQuotes
    public let whitespace: Subgroups = .whitespace
    public let multipleSpaces: Subgroups = .multipleSpaces
}
