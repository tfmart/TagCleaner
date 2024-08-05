//
//  ReleaseInformationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation
import RegexBuilder

/// A filter for cleaning release information from titles.
///
/// This filter group includes subfilters for:
/// - Remastered versions (e.g., "Remastered", "2021 Remaster")
/// - Reissues (e.g., "2020 Re-issue")
/// - Version information (e.g., "Deluxe Version", "Extended Edition")
/// - Anniversary editions (e.g., "20th Anniversary Edition")
/// - EP indicators (e.g., "- EP", "(EP)")
/// - Single indicators (e.g., "- Single", "[Single]")
/// - Remix indicators (e.g., "Remix", "RMX")
/// - Edit indicators (e.g., "Edit", "Edited Version")
///
/// Use this filter to remove common release-related suffixes and parentheticals
/// from song or album titles.
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
    
    /// A filter for removing EP information.
    public let ep: Subgroups = .ep
    
    /// A filter for removing single release information.
    public let single: Subgroups = .single
    
    /// A filter for removing a remix or edit credit from the release information
    public let remix: Subgroups = .remix
    
    /// A filter for removing a bonus track tag from the release information
    public let bonusTrack: Subgroups = .bonusTrack
    
    /// The regex pattern used for filtering release information.
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.remaster.regex
            Subgroups.reissue.regex
            Subgroups.version.regex
            Subgroups.anniversary.regex
            Subgroups.single.regex
            Subgroups.ep.regex
            Subgroups.remix.regex
            Subgroups.bonusTrack.regex
        }
    }
    
    /// Enum representing the subgroups of release information filters.
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case remaster
        case reissue
        case version
        case anniversary
        case single
        case ep
        case remix
        case bonusTrack
        
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
            case .ep:
                Regex {
                    ChoiceOf {
                        Regex { "- EP" }
                        Regex { "(EP)" }
                        Regex { "[EP]" }
                    }
                }
                .anchorsMatchLineEndings()
                .ignoresCase()
            case .single:
                Regex {
                    ChoiceOf {
                        Regex { "- Single" }
                        Regex { "(Single)" }
                        Regex { "[Single]" }
                    }
                }
                .anchorsMatchLineEndings()
                .ignoresCase()
            case .remix:
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
                        "Remix"
                        "Edit"
                        "Mix"
                        "Dub"
                        "Version"
                        "Remixed"
                        "RMX"
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
                .anchorsMatchLineEndings()
                
            case .bonusTrack:
                Regex {
                    ChoiceOf {
                        Regex { " - " }
                        Regex { " (" }
                        Regex { " [" }
                    }
                    ChoiceOf {
                        "Bonus Track"
                        "Bonus"
                    }
                    ZeroOrMore(.anyNonNewline)
                    Optionally(Regex {
                        ChoiceOf {
                            ")"
                            "]"
                        }
                    })
                }
                .anchorsMatchLineEndings()
                .ignoresCase()
            }
        }
    }
}
