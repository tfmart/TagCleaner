//
//  TCFilter.swift
//
//
//  Created by Tomas Martins on 05/12/23.
//

import Foundation

public enum TCFilter: Int8, CaseIterable {
    case cleanExplicit
    case featuredArtists
    case remastered
    case reissue
    case remix
    case single
    case ep
    case bonusTrack
    case live
    case parody
    case version
    case youtube
    case additionalArtists
    
    private var regex: TCRegex {
        .init()
    }
    
    internal var expressions: [any RegexComponent] {
        switch self {
        case .cleanExplicit:
            [
                regex.cleanExplicit
            ]
        case .featuredArtists:
            [
                regex.feature
            ]
        case .remastered:
            [
                regex.liveRemasteredRegex,
                regex.bracketsRemasteredRegex,
                regex.parenthesesRemasteredRegex,
                regex.prefixRemasteredRegex,
                regex.suffixRemasteredRegex
            ]
        case .reissue:
            [
                regex.dashReissueRegex,
                regex.bracketsReissueRegex,
                regex.parenthesesReissueRegex
            ]
        case .remix:
            [
                regex.remixRegex
            ]
            
        case .single:
            [
                regex.singleRegex
            ]
            
        case .ep:
            [
                regex.epRegex
            ]
        case .bonusTrack:
            [
                regex.bonusTrackRegex
            ]
        case .live:
            [
                regex.liveRegex
            ]
        case .parody:
            [
                regex.parodyRegex
            ]
        case .version:
            [
                regex.versionRegex
            ]
        case .youtube:
            [
                regex.youTubeRegex
            ]
        case .additionalArtists:
            [
                regex.additionalArtists
            ]
        }
    }
}
