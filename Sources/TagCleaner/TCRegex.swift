//
//  File.swift
//  
//
//  Created by Tomas Martins on 05/12/23.
//

import Foundation
import RegexBuilder

struct TCRegex {
    // MARK: - Explicit/Clean
    let cleanExplicit = Regex {
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
    
    // MARK: - feat.
    let feature = Regex {
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
    
    // MARK: - Remastered
    let liveRemasteredRegex = Regex {
        "/Live"
        One(.whitespace)
        "/"
        One(.whitespace)
        "Remastered/"
    }
    
    let parenthesesRemasteredRegex = Regex {
        One(.whitespace)
        One(.anyOf("[("))
        ZeroOrMore {
            #/./#
        }
        "Re"
        Optionally {
            "-"
        }
        One(.anyOf("Mm"))
        "aster"
        Optionally {
            Capture {
                "ed"
            }
        }
        ZeroOrMore {
            #/./#
        }
        One(.anyOf("])"))
        #/$/#
    }
    
    let suffixRemasteredRegex = Regex {
        One(.whitespace)
        "-"
        One(.whitespace)
        Repeat(count: 4) {
            One(.digit)
        }
        Optionally {
            Capture {
                Regex {
                    One(.whitespace)
                    "-"
                }
            }
        }
        One(.whitespace)
        ZeroOrMore {
            #/./#
        }
        "Re"
        Optionally {
            "-"
        }
        One(.anyOf("Mm"))
        "aster"
        Optionally {
            Capture {
                "ed"
            }
        }
        ZeroOrMore {
            #/./#
        }
        #/$/#
    }
    
    let prefixRemasteredRegex = Regex {
        One(.whitespace)
        "-"
        One(.whitespace)
        "Re"
        Optionally {
            "-"
        }
        One(.anyOf("Mm"))
        "aster"
        Optionally {
            Capture {
                "ed"
            }
        }
        ZeroOrMore {
            #/./#
        }
        #/$/#
    }
    
    let bracketsRemasteredRegex = Regex {
        One(.whitespace)
        "[Remastered]"
        One(.whitespace)
        "(Remastered"
        One(.whitespace)
        "Version)"
        #/$/#
    }
    
    //MARK: - Reissue
    let dashReissueRegex = Regex {
        One(.whitespace)
        "Re"
        Optionally {
            "-"
        }
        "issue"
        #/$/#
    }
    
    let bracketsReissueRegex = Regex {
        One(.whitespace)
        "["
        ZeroOrMore(.reluctant) {
            #/./#
        }
        "Re"
        Optionally {
            "-"
        }
        "issue"
        ZeroOrMore(.reluctant) {
            #/./#
        }
        "]"
    }
    
    let parenthesesReissueRegex = Regex {
        One(.whitespace)
        "("
        ZeroOrMore(.reluctant) {
            #/./#
        }
        "Re"
        Optionally {
            "-"
        }
        "issue"
        ZeroOrMore(.reluctant) {
            #/./#
        }
        ")"
    }
    
    //MARK: - Remix
    let remixRegex = Regex {
        ChoiceOf {
            Regex {
                ZeroOrMore(.whitespace)
                "("
                ZeroOrMore {
                    #/./#
                }
                ChoiceOf {
                    "Remix"
                    "Edit"
                    "Mix"
                    "Dub"
                    "Version"
                }
                ZeroOrMore {
                    #/./#
                }
                ")"
                ZeroOrMore(.whitespace)
            }
            Regex {
                ZeroOrMore(.whitespace)
                "["
                ZeroOrMore {
                    #/./#
                }
                ChoiceOf {
                    "Remix"
                    "Edit"
                    "Mix"
                    "Dub"
                    "Version"
                }
                ZeroOrMore {
                    #/./#
                }
                "]"
                ZeroOrMore(.whitespace)
            }
        }
    }
}
