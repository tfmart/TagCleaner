//
//  ParodyAndCoverFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct ParodyAndCoverFilter: TCFilterApplierGroup {
    var regex: String {
        "parodyAndCover"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case parody
        case cover
        
        var regex: String {
            switch self {
            case .parody:
                "parody"
            case .cover:
                "cover"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var parody: Subgroups = .parody
    static var cover: Subgroups = .cover
}