//
//  FormattingStandardizationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct FormattingStandardizationFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.featuringArtistFormat.regex
            Subgroups.parenthesesBrackets.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case featuringArtistFormat
        case parenthesesBrackets
        
        public var regex: some RegexComponent {
            switch self {
            case .featuringArtistFormat:
                Regex {
                    ChoiceOf {
                        "("
                        "["
                    }
                    ChoiceOf {
                        "feat."
                        "ft."
                        "featuring"
                    }
                    OneOrMore(.any)
                    ChoiceOf {
                        ")"
                        "]"
                    }
                }
                .ignoresCase()
            case .parenthesesBrackets:
                Regex {
                    ChoiceOf {
                        Regex {
                            "("
                            OneOrMore(.any)
                            ")"
                        }
                        Regex {
                            "["
                            OneOrMore(.any)
                            "]"
                        }
                    }
                }
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let featuringArtistFormat: Subgroups = .featuringArtistFormat
    public let parenthesesBrackets: Subgroups = .parenthesesBrackets
}
