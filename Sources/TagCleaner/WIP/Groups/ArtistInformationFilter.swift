//
//  ArtistInformationFilter.swift
//  
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct ArtistInformationFilter: TCFilterApplierGroup {
    var regex: String {
        "artistInformation"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case featuredArtists
        case additionalArtists
        
        var regex: String {
            switch self {
            case .featuredArtists:
                "featuredArtists"
            case .additionalArtists:
                "additionalArtists"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var featuredArtists: Subgroups = .featuredArtists
    static var additionalArtists: Subgroups = .additionalArtists
}
