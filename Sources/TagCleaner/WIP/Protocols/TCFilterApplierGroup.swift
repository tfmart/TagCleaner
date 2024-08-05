//
//  TCFilterApplierGroup.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import Foundation

protocol TCFilterApplierGroup: TCFilterApplier {
    var subgroups: [TCFilterApplier] { get }
}
