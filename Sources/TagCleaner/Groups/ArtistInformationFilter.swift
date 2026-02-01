//
//  ArtistInformationFilter.swift
//  
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

/// A filter for cleaning up artist information in titles.
/// This filter group includes subfilters for:
/// - Featured artists (e.g., "feat. Artist B", "(feat. Artist C)")
/// - Additional artists (e.g., "& Artist D", "x Artist E")
public struct ArtistInformationFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.featuredArtists.regex
            Subgroups.additionalArtists.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case featuredArtists
        case additionalArtists
        
        public var regex: some RegexComponent {
            switch self {
            case .featuredArtists:
                Regex {
                    ChoiceOf {
                        Regex {
                            "("
                            ChoiceOf {
                                "feat. "
                                "ft. "
                            }
                            OneOrMore(.anyNonNewline.subtracting(.anyOf(")")))
                            ")"
                            Optionally(" ")
                        }
                        Regex {
                            "["
                            ChoiceOf {
                                "feat. "
                                "ft. "
                            }
                            OneOrMore(.anyNonNewline.subtracting(.anyOf("]")))
                            "]"
                            Optionally(" ")
                        }
                        Regex {
                            ChoiceOf {
                                " feat. "
                                " ft. "
                            }
                            OneOrMore(.anyNonNewline.subtracting(.anyOf("([")))
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
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let featuredArtists: Subgroups = .featuredArtists
    public let additionalArtists: Subgroups = .additionalArtists
}
