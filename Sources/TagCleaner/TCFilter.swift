//
//  File.swift
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
                regex.remix
            ]
        }
    }
}
