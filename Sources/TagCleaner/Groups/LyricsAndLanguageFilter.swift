//
//  LyricsAndLanguageFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

import RegexBuilder

/// A filter for removing lyrics and language indicators from titles.
/// This filter group includes subfilters for:
/// - Lyrics indicators (e.g., "(Lyric Video)", "(With Lyrics)")
/// - Language subtitles (e.g., "Sub Español", "(Letra)")
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
