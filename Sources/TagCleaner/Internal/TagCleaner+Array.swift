//
//  TagCleaner+Array.swift
//  TagCleaner
//
//  Created by Tomas Martins on 05/08/24.
//

internal extension TagCleaner {
    func apply(_ input: String, filters: [any TCFilterApplier]) -> String {
        var result = input
        for filter in filters {
            result = filter.replace(result)
        }
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
