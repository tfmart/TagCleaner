//
//  ArtistInformationFilter.swift
//  
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

struct ArtistInformationFilter: TCFilterApplierGroup {
    var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.featuredArtists.regex
            Subgroups.additionalArtists.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case featuredArtists
        case additionalArtists
        
        var regex: some RegexComponent {
            switch self {
            case .featuredArtists:
                Regex {
                    ChoiceOf {
                        Regex {
                            ChoiceOf {
                                "("
                                "["
                            }
                            "feat. "
                            OneOrMore(.any)
                            ChoiceOf {
                                ")"
                                "]"
                            }
                        }
                        Regex {
                            " feat. "
                            OneOrMore(.any)
                        }
                    }
                }
                .ignoresCase()
            case .additionalArtists:
                Regex {
                    ChoiceOf {
                        Regex {
                            " & "
                            OneOrMore(.any)
                        }
                        Regex {
                            " x "
                            OneOrMore(.any)
                        }
                    }
                }
                .ignoresCase()
            }
        }
    }
    
    var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    static var featuredArtists: Subgroups = .featuredArtists
    static var additionalArtists: Subgroups = .additionalArtists
}

