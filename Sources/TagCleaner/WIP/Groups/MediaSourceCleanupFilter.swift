//
//  MediaSourceCleanupFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


struct MediaSourceCleanupFilter: TCFilterApplierGroup {
    var regex: String {
        "mediaSourceCleanup"
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case videoIndicators
        case audioIndicators
        case fileExtensions
        case qualityIndicators
        case dateYearInformation
        case fullAlbum
        
        var regex: String {
            switch self {
            case .videoIndicators:
                "videoIndicators"
            case .audioIndicators:
                "audioIndicators"
            case .fileExtensions:
                "fileExtensions"
            case .qualityIndicators:
                "qualityIndicators"
            case .dateYearInformation:
                "dateYearInformation"
            case .fullAlbum:
                "fullAlbum"
            }
        }
    }
    
    var subgroups: [TCFilterApplier] { Subgroups.allCases }
    
    static var videoIndicators: Subgroups = .videoIndicators
    static var audioIndicators: Subgroups = .audioIndicators
    static var fileExtensions: Subgroups = .fileExtensions
    static var qualityIndicators: Subgroups = .qualityIndicators
    static var dateYearInformation: Subgroups = .dateYearInformation
    static var fullAlbum: Subgroups = .fullAlbum
}