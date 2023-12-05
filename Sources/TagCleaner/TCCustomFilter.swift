//
//  TCCustomFilter.swift
//
//
//  Created by Tomas Martins on 05/12/23.
//

import Foundation

public struct TCCustomFilter {
    private let filters: [TCFilter]
    
    public init(filters: [TCFilter]) {
        self.filters = filters
    }
    
    public func filter(_ input: String) -> String {
        var filteredInput = input
        
        for filter in filters {
            for expression in filter.expressions {
                filteredInput = filteredInput.replacing(expression, with: "")
            }
        }
        
        return filteredInput
    }
}
