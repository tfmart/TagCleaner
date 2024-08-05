//
//  PerformanceTypeFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct PerformanceTypeFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.live.regex
            Subgroups.acoustic.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case live
        case acoustic
        
        var regex: some RegexComponent {
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
    
    static var live: Subgroups = .live
    static var acoustic: Subgroups = .acoustic
}
