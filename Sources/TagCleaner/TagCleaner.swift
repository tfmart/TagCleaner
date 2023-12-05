//
//  TagCleaner.swift
//
//
//  Created by Tomas Martins on 04/12/23.
//

import Foundation
import RegexBuilder

public struct TCFilterRule {
    /// String or pattern to replace.
    public let source: Regex<Substring>
    /// Replacement string.
    public let target: String
}

public struct TCFilter {
    public static var cleanExplicitFilterRules: [TCFilterRule] {
        let regex = Regex {
            One(.whitespace)
            ChoiceOf {
                Regex {
                    "["
                    ChoiceOf {
                        "Explicit"
                        "Clean"
                    }
                    "]"
                }
                Regex {
                    "("
                    ChoiceOf {
                        "Explicit"
                        "Clean"
                    }
                    ")"
                }
            }
        }
        return [TCFilterRule(source: regex,
                             target: "")]
    }
    
    public static var featureFilterRules: [TCFilterRule] {
        let regex = Regex {
            ChoiceOf {
                Regex {
                    ZeroOrMore(.whitespace)
                    "(feat."
                    ZeroOrMore(CharacterClass(.anyOf(")"), .anyOf(")")).inverted)
                    ")"
                }
                Regex {
                    ZeroOrMore(.whitespace)
                    "[feat."
                    ZeroOrMore(CharacterClass(.anyOf("]"), .anyOf("]")).inverted)
                    "]"
                }
                Regex {
                    ZeroOrMore(.whitespace)
                    "feat."
                    ZeroOrMore(.any)
                }
            }
        }
        
        return [TCFilterRule(source: regex,
                             target: "")]
    }
    
    public static var liveFilterRules: [TCFilterRule] {
        let regex = Regex {
            OneOrMore(.whitespace)
            "-"
            OneOrMore(.whitespace)
            ChoiceOf {
                Regex {
                    ChoiceOf {
                        "Live"
                        Regex {
                            "Live at"
                            ZeroOrMore(.any)
                        }
                    }
                }
                
                Regex {
                    "(Live)"
                }
            }
        }
        
        return [TCFilterRule(source: regex,
                             target: "")]
    }
}
