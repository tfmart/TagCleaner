//
//  PerformanceTypeFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

/// A filter for removing performance type indicators from titles.
/// This filter group includes subfilters for:
/// - Live performances (e.g., "Live at Wembley", "(Live)")
/// - Acoustic performances (e.g., "Acoustic Version", "(Acoustic)")
public struct PerformanceTypeFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.live.regex
            Subgroups.acoustic.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case live
        case acoustic
        
        public var regex: some RegexComponent {
            switch self {
            case .live:
                Regex {
                    ChoiceOf {
                        Regex {
                            " - "
                            "Live"
                            ZeroOrMore(.anyNonNewline)
                        }
                        Regex {
                            "("
                            "Live"
                            ")"
                        }
                    }
                }
                .anchorsMatchLineEndings()
            case .acoustic:
                Regex {
                    ChoiceOf {
                        Regex {
                            " - "
                            "Acoustic"
                            ZeroOrMore(.anyNonNewline)
                        }
                        Regex {
                            "("
                            "Acoustic"
                            ")"
                        }
                    }
                }
                .anchorsMatchLineEndings()
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let live: Subgroups = .live
    public let acoustic: Subgroups = .acoustic
}
