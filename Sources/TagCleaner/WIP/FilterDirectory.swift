//
//  FilterDirectory.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


import Foundation

struct FilterDirectory {
    static var releaseInformation: ReleaseInformationFilter = .init()
    static var performanceType: PerformanceTypeFilter = .init()
    static var contentLabel: ContentLabelFilter = .init()
    static var artistInformation: ArtistInformationFilter = .init()
    static var trackSuffixStandardization: TrackSuffixStandardizationFilter = .init()
    static var parodyAndCover: ParodyAndCoverFilter = .init()
    static var mediaSourceCleanup: MediaSourceCleanupFilter = .init()
    static var lyricsAndLanguage: LyricsAndLanguageFilter = .init()
    static var textNormalization: TextNormalizationFilter = .init()
    static var formattingStandardization: FormattingStandardizationFilter = .init()
    static var miscellaneousCleanup: MiscellaneousCleanupFilter = .init()
}
