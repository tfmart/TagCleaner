//
//  TagFilterBuilder.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

@resultBuilder
public struct TagFilterBuilder {
    public static func buildBlock(_ components: TCFilter...) -> [TCFilter] {
        components
    }
}
