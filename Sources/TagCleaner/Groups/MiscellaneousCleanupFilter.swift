//
//  MiscellaneousCleanupFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

import RegexBuilder

/// A filter for miscellaneous cleanup tasks in titles.
/// This filter group includes subfilters for:
/// - Specific suffixes (e.g., "(Album Track)", "(Single)")
/// - Leading and trailing punctuation (e.g., removing extra periods at start/end)
public struct MiscellaneousCleanupFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.specificSuffixes.regex
            Subgroups.leadingTrailingPunctuation.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case specificSuffixes
        case leadingTrailingPunctuation
        
        public var regex: some RegexComponent {
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
    
    public let specificSuffixes: Subgroups = .specificSuffixes
    public let leadingTrailingPunctuation: Subgroups = .leadingTrailingPunctuation
}
