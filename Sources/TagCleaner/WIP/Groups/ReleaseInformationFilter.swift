//
//  ReleaseInformationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation
import RegexBuilder

struct ReleaseInformationFilter: TCFilterApplierGroup {
    var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.reissue.regex
            Subgroups.reissue.regex
            Subgroups.version.regex
            Subgroups.anniversary.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case remaster
        case reissue
        case version
        case anniversary
        
        var regex: some RegexComponent {
            switch self {
            case .remaster:
                Regex {
                    Optionally(Regex {
                        ChoiceOf {
                            "["
                            "("
                        }
                    })
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
                    ChoiceOf {
                        "Re-issue"
                        "Reissue"
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
            case .version:
                Regex {
                    Optionally(Regex {
                        ChoiceOf {
                            "["
                            "("
                        }
                    })
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
    
    var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    static var remaster: Subgroups = .remaster
    static var reissue: Subgroups = .reissue
    static var version: Subgroups = .version
    static var anniversary: Subgroups = .anniversary
}
