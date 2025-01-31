//
//  MediaSourceCleanupFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


import RegexBuilder

/// A filter for cleaning up media source information from titles.
/// This filter group includes subfilters for:
/// - Video indicators (e.g., "(Official Video)", "- Music Video")
/// - Audio indicators (e.g., "(Official Audio)", "- Audio")
/// - File extensions (e.g., ".mp3", ".wav")
/// - Quality indicators (e.g., "HD", "HQ")
/// - Date and year information (e.g., "(2021)")
/// - Full album indicators (e.g., "Full Album")
public struct MediaSourceCleanupFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.videoIndicators.regex
            Subgroups.audioIndicators.regex
            Subgroups.fileExtensions.regex
            Subgroups.qualityIndicators.regex
            Subgroups.dateYearInformation.regex
            Subgroups.fullAlbum.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case videoIndicators
        case audioIndicators
        case fileExtensions
        case qualityIndicators
        case dateYearInformation
        case fullAlbum
        
        public var regex: some RegexComponent {
            switch self {
            case .videoIndicators:
                Regex {
                    ChoiceOf {
                        Regex {
                            ChoiceOf {
                                "("
                                "["
                            }
                            ChoiceOf {
                                "Official Video"
                                "Music Video"
                                "Video"
                            }
                            ChoiceOf {
                                ")"
                                "]"
                            }
                        }
                        Regex {
                            " - "
                            ChoiceOf {
                                "Official Video"
                                "Music Video"
                                "Video"
                            }
                        }
                    }
                }
                .ignoresCase()
            case .audioIndicators:
                Regex {
                    ChoiceOf {
                        Regex {
                            ChoiceOf {
                                "("
                                "["
                            }
                            ChoiceOf {
                                "Official Audio"
                                "Audio"
                            }
                            ChoiceOf {
                                ")"
                                "]"
                            }
                        }
                        Regex {
                            " - "
                            ChoiceOf {
                                "Official Audio"
                                "Audio"
                            }
                        }
                    }
                }
                .ignoresCase()
            case .fileExtensions:
                Regex {
                    "."
                    ChoiceOf {
                        "mp3"
                        "wav"
                        "flac"
                        "m4a"
                        "ogg"
                    }
                }
                .anchorsMatchLineEndings()
                .ignoresCase()
            case .qualityIndicators:
                Regex {
                    ChoiceOf {
                        " HD"
                        " HQ"
                        "(HD)"
                        "(HQ)"
                    }
                }
                .anchorsMatchLineEndings()
                .ignoresCase()
            case .dateYearInformation:
                Regex {
                    ChoiceOf {
                        "("
                        "["
                    }
                    Repeat(.digit, count: 4)
                    ChoiceOf {
                        ")"
                        "]"
                    }
                }
            case .fullAlbum:
                Regex {
                    ZeroOrMore(" -")
                    " Full Album"
                }
                .anchorsMatchLineEndings()
                .ignoresCase()
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let videoIndicators: Subgroups = .videoIndicators
    public let audioIndicators: Subgroups = .audioIndicators
    public let fileExtensions: Subgroups = .fileExtensions
    public let qualityIndicators: Subgroups = .qualityIndicators
    public let dateYearInformation: Subgroups = .dateYearInformation
    public let fullAlbum: Subgroups = .fullAlbum
}
