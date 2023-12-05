//
//  TagCleaner.swift
//
//
//  Created by Tomas Martins on 04/12/23.
//

import Foundation
import RegexBuilder

public struct TagCleaner {
    internal var regex = TCRegex()
    
    internal func filter(_ regex: any RegexComponent, from input: String) -> String {
        return input.replacing(regex, with: "")
    }
    
    internal func filter(_ expressions: [any RegexComponent], from input: String) -> String {
        var filteredOutout = input
        for regex in expressions {
            filteredOutout = filteredOutout.replacing(regex, with: "")
        }
        return filteredOutout
    }
    
    func removeCleanExplicit(from input: String) -> String {
        return filter(regex.cleanExplicit, from: input)
    }
    
    func removeFeature(from input: String) -> String {
        return filter(regex.feature, from: input)
    }
    
    func removeRemastered(from input: String) -> String {
        let expressions: [any RegexComponent] = [
            regex.liveRemasteredRegex,
            regex.bracketsRemasteredRegex,
            regex.parenthesesRemasteredRegex,
            regex.prefixRemasteredRegex,
            regex.suffixRemasteredRegex,
        ]
        
        return filter(expressions, from: input)
    }
    
    func removeReissue(from input: String) -> String {
        let expressions: [any RegexComponent] = [
            regex.dashReissueRegex,
            regex.bracketsReissueRegex,
            regex.parenthesesReissueRegex
        ]
        
        return filter(expressions, from: input)
    }
}
