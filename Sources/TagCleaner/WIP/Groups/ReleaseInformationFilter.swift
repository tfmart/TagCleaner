//
//  ReleaseInformationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct ReleaseInformationFilter: TCFilterApplierGroup {
    var regex: String {
        "releaseInformation"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case remaster
        case reissue
        case version
        case anniversary
        
        var regex: String {
            switch self {
            case .remaster:
                "remaster"
            case .reissue:
                "reissue"
            case .version:
                "version"
            case .anniversary:
                "anniversary"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var remaster: Subgroups = .remaster
    static var reissue: Subgroups = .reissue
    static var version: Subgroups = .version
    static var anniversary: Subgroups = .anniversary
}
