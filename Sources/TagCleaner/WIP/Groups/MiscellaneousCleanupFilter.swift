//
//  MiscellaneousCleanupFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct MiscellaneousCleanupFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.specificSuffixes.regex
            Subgroups.leadingTrailingPunctuation.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case specificSuffixes
        case leadingTrailingPunctuation
        
        var regex: some RegexComponent {
            switch self {
            case .specificSuffixes:
                Regex {
                    ChoiceOf {
                        " (Album Track)"
                        " (Single)"
                        " (Album)"
                    }
                }
                .ignoresCase()
            case .leadingTrailingPunctuation:
                Regex {
                    ChoiceOf {
                        Regex {
                            Anchor.startOfSubject
                            OneOrMore(".")
                        }
                        Regex {
                            OneOrMore(".")
                            Anchor.endOfSubject
                        }
                    }
                }
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    static var specificSuffixes: Subgroups = .specificSuffixes
    static var leadingTrailingPunctuation: Subgroups = .leadingTrailingPunctuation
}
