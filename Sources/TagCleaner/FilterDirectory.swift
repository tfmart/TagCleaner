//
//  FilterDirectory.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//


import Foundation

/// A struct that provides access to various predefined filters for cleaning music metadata.
public struct FilterDirectory {
    /// A filter for cleaning release information from titles.
    ///
    /// This filter removes information related to remasters, reissues, special editions, and anniversary releases.
    ///
    /// Example:
    /// - Input: "Song Title (2021 Remaster)"
    /// - Output: "Song Title"
    public static var releaseInformation: ReleaseInformationFilter = .init()

    /// A filter for removing performance type indicators from titles.
    ///
    /// This filter removes indicators for live performances and acoustic versions.
    ///
    /// Example:
    /// - Input: "Song Title (Live at Wembley)"
    /// - Output: "Song Title"
    public static var performanceType: PerformanceTypeFilter = .init()

    /// A filter for removing content labels from titles.
    ///
    /// This filter removes explicit and clean content labels.
    ///
    /// Example:
    /// - Input: "Song Title [Explicit]"
    /// - Output: "Song Title"
    public static var contentLabel: ContentLabelFilter = .init()

    /// A filter for cleaning up artist information in titles.
    ///
    /// This filter removes information about featured artists and additional collaborators.
    ///
    /// Example:
    /// - Input: "Song Title (feat. Another Artist)"
    /// - Output: "Song Title"
    public static var artistInformation: ArtistInformationFilter = .init()

    /// A filter for removing parody and cover information from titles.
    ///
    /// This filter removes indications that a song is a parody or cover of another work.
    ///
    /// Example:
    /// - Input: "Funny Song (Parody of \"Original Song\" by Original Artist)"
    /// - Output: "Funny Song"
    public static var parodyAndCover: ParodyAndCoverFilter = .init()

    /// A filter for cleaning up media source information from titles.
    ///
    /// This filter removes indicators related to video, audio, file types, quality, and release dates.
    ///
    /// Example:
    /// - Input: "Song Title (Official Video) [HD]"
    /// - Output: "Song Title"
    public static var mediaSourceCleanup: MediaSourceCleanupFilter = .init()

    /// A filter for removing lyrics and language indicators from titles.
    ///
    /// This filter removes mentions of lyrics, translations, and language-specific information.
    ///
    /// Example:
    /// - Input: "Song Title (With Lyrics)"
    /// - Output: "Song Title"
    public static var lyricsAndLanguage: LyricsAndLanguageFilter = .init()

    /// A filter for normalizing text in titles.
    ///
    /// This filter handles various text normalization tasks such as removing HTML entities and standardizing whitespace.
    ///
    /// Example:
    /// - Input: "Song&nbsp;Title"
    /// - Output: "Song Title"
    public static var textNormalization: TextNormalizationFilter = .init()

    /// A filter for standardizing formatting in titles.
    ///
    /// This filter standardizes common formatting issues such as featuring artist mentions and unnecessary parentheses.
    ///
    /// Example:
    /// - Input: "Song Title (ft. Another Artist)"
    /// - Output: "Song Title"
    public static var formattingStandardization: FormattingStandardizationFilter = .init()

    /// A filter for miscellaneous cleanup tasks in titles.
    ///
    /// This filter handles various edge cases and common issues not covered by other filters.
    ///
    /// Example:
    /// - Input: "Song Title (Album Track)"
    /// - Output: "Song Title"
    public static var miscellaneousCleanup: MiscellaneousCleanupFilter = .init()
}
