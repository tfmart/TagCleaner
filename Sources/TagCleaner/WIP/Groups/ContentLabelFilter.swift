//
//  ContentLabelFilter.swift
//
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

struct ContentLabelFilter: TCFilterApplierGroup {
    var regex: String {
        "contentLabel"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case explicit
        case clean
        
        var regex: String {
            switch self {
            case .explicit:
                "explicit"
            case .clean:
                "clean"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var explicit: Subgroups = .explicit
    static var clean: Subgroups = .clean
}
