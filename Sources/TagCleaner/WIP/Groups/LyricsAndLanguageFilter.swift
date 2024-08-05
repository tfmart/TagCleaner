//
//  LyricsAndLanguageFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct LyricsAndLanguageFilter: TCFilterApplierGroup {
    var regex: String {
        "lyricsAndLanguage"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case lyricsIndicators
        case languageSubtitles
        
        var regex: String {
            switch self {
            case .lyricsIndicators:
                "lyricsIndicators"
            case .languageSubtitles:
                "languageSubtitles"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var lyricsIndicators: Subgroups = .lyricsIndicators
    static var languageSubtitles: Subgroups = .languageSubtitles
}