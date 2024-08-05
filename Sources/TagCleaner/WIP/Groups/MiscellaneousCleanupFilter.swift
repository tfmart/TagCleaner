//
//  MiscellaneousCleanupFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct MiscellaneousCleanupFilter: TCFilterApplierGroup {
    var regex: String {
        "miscellaneousCleanup"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case specificSuffixes
        case leadingTrailingPunctuation
        
        var regex: String {
            switch self {
            case .specificSuffixes:
                "specificSuffixes"
            case .leadingTrailingPunctuation:
                "leadingTrailingPunctuation"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var specificSuffixes: Subgroups = .specificSuffixes
    static var leadingTrailingPunctuation: Subgroups = .leadingTrailingPunctuation
}