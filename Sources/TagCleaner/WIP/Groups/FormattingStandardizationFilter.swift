//
//  FormattingStandardizationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct FormattingStandardizationFilter: TCFilterApplierGroup {
    var regex: String {
        "formattingStandardization"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case featuringArtistFormat
        case parenthesesBrackets
        
        var regex: String {
            switch self {
            case .featuringArtistFormat:
                "featuringArtistFormat"
            case .parenthesesBrackets:
                "parenthesesBrackets"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var featuringArtistFormat: Subgroups = .featuringArtistFormat
    static var parenthesesBrackets: Subgroups = .parenthesesBrackets
}