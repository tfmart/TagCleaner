//
//  TrackSuffixStandardizationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct TrackSuffixStandardizationFilter: TCFilterApplierGroup {
    var regex: String {
        "trackSuffixStandardization"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case remix
        case edit
        
        var regex: String {
            switch self {
            case .remix:
                "remix"
            case .edit:
                "edit"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var remix: Subgroups = .remix
    static var edit: Subgroups = .edit
}