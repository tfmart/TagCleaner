//
//  TCFilterApplierGroup.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

public protocol TCFilterApplierGroup: TCFilterApplier {
    var subgroups: [any TCFilterApplier] { get }
}
