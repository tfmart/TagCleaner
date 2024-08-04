//
//  TCRegex.swift
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
    let liveRegex = Regex {
        ChoiceOf {
            Regex {
                One(.whitespace)
                "-"
                One(.whitespace)
                "Live"
                Optionally {
                    One(.whitespace)
                    OneOrMore(.word)
                }
                Anchor.endOfLine
            }
            Regex {
                One(.whitespace)
                "("
                "Live"
                ")"
                Anchor.endOfLine
            }
        }
    }
    
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
    
    //MARK: - Single/EP
    let singleRegex = Regex {
        One(.whitespace)
        "-"
        One(.whitespace)
        "Single"
    }
    
    let epRegex = Regex {
        One(.whitespace)
        "-"
        One(.whitespace)
        "EP"
    }
    
    //MARK: - Bonus Track
    let bonusTrackRegex = Regex {
        ZeroOrMore(.whitespace)
        One(.anyOf("[("))
        ZeroOrMore(.whitespace)
        "Bonus"
        Optionally {
            ZeroOrMore(.whitespace)
            "Track"
        }
        One(.anyOf(")]"))
    }
    
    //MARK: - Parody
    let parodyRegex = Regex {
        One(.whitespace)
        "("
        ChoiceOf {
            "Parody of"
            "Lyrical Adaption of"
        }
        OneOrMore(.any)
        ")"
        Anchor.endOfLine
    }
    
    //MARK: - Version
    let versionRegex = Regex {
        ChoiceOf {
            Regex {
                One(.whitespace)
                ChoiceOf {
                    "("
                    "["
                }
                ChoiceOf {
                    "Album Version"
                    "Re-recorded"
                    "Rerecorded"
                    "Single Version"
                    "Edit"
                    "Deluxe Edition"
                    "Expanded"
                    OneOrMore(.word)
                    "Anniversary"
                }
                OneOrMore(.any)
                ChoiceOf {
                    ")"
                    "]"
                }
            }
            Regex {
                One(.whitespace)
                "-"
                One(.whitespace)
                ChoiceOf {
                    "Mono Version"
                    "Stereo Version"
                    "Expanded Edition"
                    "Original"
                }
                Optionally {
                    OneOrMore(.any)
                }
            }
        }
        Anchor.endOfLine
    }
    
    //MARK: - Trim
    let trimRegex = Regex {
        ChoiceOf {
            Regex {
                Anchor.startOfLine
                OneOrMore(.anyOf("/,:;~- \""))
            }
            Regex {
                OneOrMore(.anyOf("/,:;~- \""))
                Anchor.endOfLine
            }
            Regex {
                OneOrMore(.whitespace)
            }
        }
    }
    
    //MARK: - YouTube
    let youTubeRegex = Regex {
        ChoiceOf {
            Regex {
                OneOrMore("*")
                ZeroOrMore(.whitespace)
                OneOrMore(.word)
                ZeroOrMore(.whitespace)
                OneOrMore("*")
            }
            Regex {
                "["
                OneOrMore(.word)
                "]"
            }
            Regex {
                "【"
                OneOrMore(.word)
                "】"
            }
            Regex {
                "（"
                OneOrMore(.word)
                "）"
            }
            Regex {
                "("
                OneOrMore(.any)
                "lyrics"
                ZeroOrMore(.any)
                ")"
            }
            Regex {
                "("
                ZeroOrMore(.any)
                ChoiceOf {
                    "official"
                    "track"
                    "audio"
                    "stream"
                    "video"
                }
                ZeroOrMore(.any)
                ")"
            }
            Regex {
                "-"
                ZeroOrMore(.any)
                ChoiceOf {
                    "official"
                    "music"
                    "video"
                    "audio"
                }
            }
            Regex {
                ChoiceOf {
                    "HD"
                    "HQ"
                }
                ZeroOrMore(.whitespace)
                Optionally {
                    Anchor.endOfLine
                }
            }
            Regex {
                ChoiceOf {
                    "video clip"
                    "clip"
                    "full album"
                }
            }
            Regex {
                "|"
                ZeroOrMore(.any)
            }
        }
    }
    
    //MARK: - Additional Artists
    let additionalArtists =  Regex {
        One(.whitespace)
        ChoiceOf {
            Regex {
                "&"
                One(.whitespace)
                OneOrMore(.any)
            }
            Regex {
                "x"
                One(.whitespace)
                OneOrMore(.any)
            }
        }
    }
}

