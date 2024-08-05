//
//  LyricsAndLanguageFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

struct LyricsAndLanguageFilter: TCFilterApplierGroup {
    var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.lyricsIndicators.regex
            Subgroups.languageSubtitles.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case lyricsIndicators
        case languageSubtitles
        
        var regex: some RegexComponent {
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
    
    var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    static var lyricsIndicators: Subgroups = .lyricsIndicators
    static var languageSubtitles: Subgroups = .languageSubtitles
}
