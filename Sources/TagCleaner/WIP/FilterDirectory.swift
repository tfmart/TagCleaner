//
//  FilterDirectory.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


import Foundation

public struct FilterDirectory {
    public static var releaseInformation: ReleaseInformationFilter = .init()
    public static var performanceType: PerformanceTypeFilter = .init()
    public static var contentLabel: ContentLabelFilter = .init()
    public static var artistInformation: ArtistInformationFilter = .init()
    public static var trackSuffixStandardization: TrackSuffixStandardizationFilter = .init()
    public static var parodyAndCover: ParodyAndCoverFilter = .init()
    public static var mediaSourceCleanup: MediaSourceCleanupFilter = .init()
    public static var lyricsAndLanguage: LyricsAndLanguageFilter = .init()
    public static var textNormalization: TextNormalizationFilter = .init()
    public static var formattingStandardization: FormattingStandardizationFilter = .init()
    public static var miscellaneousCleanup: MiscellaneousCleanupFilter = .init()
}
