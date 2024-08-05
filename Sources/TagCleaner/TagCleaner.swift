//
//  TagCleaner.swift
//
//
//  Created by Tomas Martins on 04/12/23.
//

import Foundation

public struct TagCleaner {
    func apply(_ input: String, filter: any TCFilterApplier) -> String {
        let result = filter.replace(input)
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
