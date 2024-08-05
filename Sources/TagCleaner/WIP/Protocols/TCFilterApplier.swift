//
//  TCFilterApplier.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

public protocol TCFilterApplier {
    associatedtype RegexFilter: RegexComponent
    var regex: RegexFilter { get }
    func replace(_ input: String) -> String
}

extension TCFilterApplier {
    public func replace(_ input: String) -> String {
        input.replacing(regex, with: "")
    }
}
