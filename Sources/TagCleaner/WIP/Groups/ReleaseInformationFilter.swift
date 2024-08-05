//
//  ReleaseInformationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation
import RegexBuilder

public struct ReleaseInformationFilter: TCFilterApplierGroup {
    public  var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.reissue.regex
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
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let remaster: Subgroups = .remaster
    public let reissue: Subgroups = .reissue
    public let version: Subgroups = .version
    public let anniversary: Subgroups = .anniversary
}
