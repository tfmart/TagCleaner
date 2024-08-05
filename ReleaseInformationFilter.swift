//
//  ReleaseInformationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 05/08/24.
//


import Foundation
import RegexBuilder

/// A filter for cleaning release information from titles.
/// This filter group includes subfilters for:
/// - Remastered versions (e.g., "Remastered", "2021 Remaster")
/// - Reissues (e.g., "2020 Re-issue")
/// - Version information (e.g., "Deluxe Version", "Extended Edition")
/// - Anniversary editions (e.g., "20th Anniversary Edition")
public struct ReleaseInformationFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.remaster.regex
            Subgroups.reissue.regex
            Subgroups.version.regex
            Subgroups.anniversary.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case remaster
        case reissue
        case version
        case anniversary
        
        public var regex: some RegexComponent {
            switch self {
            case .remaster:
                Regex {
                    Optionally(Regex {
                        ChoiceOf {
                            "["
                            "("
                            "- "
                        }
                    })
                    Optionally(
                        Regex {
                            ZeroOrMore(.digit)
                            One(.whitespace)
                        }
                    )
                    Optionally(
                        Regex {
                            ZeroOrMore(.word)
                            One(.whitespace)
                        }
                    )
                    ChoiceOf {
                        "Remaster"
                        "Remastered"
                        "Re-master"
                        "Re-mastered"
                    }
                    ZeroOrMore(.anyNonNewline)
                    Optionally(Regex {
                        ChoiceOf {
                            "]"
                            ")"
                        }
                    })
                }
                .ignoresCase()
            case .reissue:
                Regex {
                    Optionally(Regex {
                        ChoiceOf {
                            "["
                            "("
                        }
                    })
                    Optionally(
                        Regex {
                            ZeroOrMore(.digit)
                            One(.whitespace)
                        }
                    )
                    ChoiceOf {
                        "Re-issue"
                        "Reissue"
                    }
                    ZeroOrMore(.anyNonNewline)
                    Optionally(Regex {
                        ChoiceOf {
                            "]"
                            ")"
                            "- "
                        }
                    })
                }
                .ignoresCase()
            case .version:
                Regex {
                    Optionally(Regex {
                        ChoiceOf {
                            "["
                            "("
                            "- "
                        }
                    })
                    Optionally(
                        Regex {
                            ZeroOrMore(.digit)
                            One(.whitespace)
                        }
                    )
                    Optionally(
                        Regex {
                            ZeroOrMore(.word)
                            One(.whitespace)
                        }
                    )
                    ChoiceOf {
                        "Version"
                        "Edition"
                    }
                    ZeroOrMore(.anyNonNewline)
                    Optionally(Regex {
                        ChoiceOf {
                            "]"
                            ")"
                        }
                    })
                }
                .ignoresCase()
            case .anniversary:
                Regex {
                    Optionally(Regex {
                        ChoiceOf {
                            "["
                            "("
                        }
                    })
                    OneOrMore(.digit)
                    Regex {
                        ChoiceOf {
                            "th"
                            "st"
                            "nd"
                            "rd"
                        }
                    }
                    " Anniversary"
                    ZeroOrMore(.anyNonNewline)
                    Optionally(Regex {
                        ChoiceOf {
                            "]"
                            ")"
                        }
                    })
                }
                .ignoresCase()
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let remaster: Subgroups = .remaster
    public let reissue: Subgroups = .reissue
    public let version: Subgroups = .version
    public let anniversary: Subgroups = .anniversary
}