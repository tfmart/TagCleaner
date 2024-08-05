//
//  LyricsAndLanguageFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct LyricsAndLanguageFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.lyricsIndicators.regex
            Subgroups.languageSubtitles.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case lyricsIndicators
        case languageSubtitles
        
        public var regex: some RegexComponent {
            switch self {
            case .lyricsIndicators:
                Regex {
                    ChoiceOf {
                        "(Lyric Video)"
                        "(Lyrics Video)"
                        "(With Lyrics)"
                    }
                }
                .ignoresCase()
            case .languageSubtitles:
                Regex {
                    ChoiceOf {
                        "Sub Español"
                        "(Letra)"
                        "(En vivo)"
                    }
                }
                .ignoresCase()
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let lyricsIndicators: Subgroups = .lyricsIndicators
    public let languageSubtitles: Subgroups = .languageSubtitles
}
