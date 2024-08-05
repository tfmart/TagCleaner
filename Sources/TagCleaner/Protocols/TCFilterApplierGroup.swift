//
//  TCFilterApplierGroup.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

/// A protocol that defines a group of filter appliers.
public protocol TCFilterApplierGroup: TCFilterApplier {
    /// An array of subgroup filter appliers.
    var subgroups: [any TCFilterApplier] { get }
}
