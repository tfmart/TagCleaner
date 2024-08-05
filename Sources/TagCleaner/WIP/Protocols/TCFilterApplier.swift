//
//  TCFilterApplier.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

protocol TCFilterApplier {
    associatedtype RegexFilter: RegexComponent
    var regex: RegexFilter { get }
}
