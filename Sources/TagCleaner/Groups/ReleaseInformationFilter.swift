//
//  ReleaseInformationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation
import RegexBuilder

/// A filter for cleaning release information from titles.
public struct ReleaseInformationFilter: TCFilterApplierGroup {
    
    /// The subgroups of release information filters.
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    /// A filter for removing remaster information.
    public let remaster: Subgroups = .remaster
    
    /// A filter for removing reissue information.
    public let reissue: Subgroups = .reissue
    
    /// A filter for removing version information.
    public let version: Subgroups = .version
    
    /// A filter for removing anniversary edition information.
    public let anniversary: Subgroups = .anniversary
    
    /// The regex pattern used for filtering release information.
    public  var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.reissue.regex
            Subgroups.reissue.regex
            Subgroups.version.regex
            Subgroups.anniversary.regex
        }
    }
    
    /// Enum representing the subgroups of release information filters.
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
}
