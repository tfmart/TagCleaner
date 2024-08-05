//
//  PerformanceTypeFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct PerformanceTypeFilter: TCFilterApplierGroup {
    var regex: String {
        "performanceType"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case live
        case acoustic
        
        var regex: String {
            switch self {
            case .live:
                "live"
            case .acoustic:
                "acoustic"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var live: Subgroups = .live
    static var acoustic: Subgroups = .acoustic
}