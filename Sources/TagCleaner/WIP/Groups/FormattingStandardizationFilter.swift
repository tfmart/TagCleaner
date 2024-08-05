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
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case featuringArtistFormat
        case parenthesesBrackets
        
        var regex: some RegexComponent {
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
    
    static var featuringArtistFormat: Subgroups = .featuringArtistFormat
    static var parenthesesBrackets: Subgroups = .parenthesesBrackets
}
