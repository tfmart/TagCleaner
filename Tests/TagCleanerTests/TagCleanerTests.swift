import XCTest
@testable import TagCleaner

final class TagCleanerTests: XCTestCase {
    
    let cleaner = TagCleaner()

    // MARK: - Artist Information Filter Tests
    
    func testFeaturedArtists() {
        let testCases = [
            ("Artist A feat. Artist B", "Artist A"),
            ("Artist A feat. Artist B, Artist C", "Artist A"),
            ("Artist A feat. Artist B, Artist C & Artist D", "Artist A"),
            ("Artist A", "Artist A"),
            ("Artist A [feat. Artist B]", "Artist A"),
            ("Artist A (feat. Artist B)", "Artist A")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.artistInformation.featuredArtists), expected)
        }
    }
    
    func testAdditionalArtists() {
        let testCases = [
            ("Artist A x Artist B", "Artist A"),
            ("Artist A & Artist B", "Artist A")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.artistInformation.additionalArtists), expected)
        }
    }
    
    // MARK: - Content Label Filter Tests
    
    func testExplicitLabel() {
        let testCases = [
            ("Track [Explicit]", "Track"),
            ("Track (Explicit)", "Track")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.contentLabel.explicit), expected)
        }
    }
    
    func testCleanLabel() {
        let testCases = [
            ("Track [Clean]", "Track"),
            ("Track (Clean)", "Track")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.contentLabel.clean), expected)
        }
    }
    
    // MARK: - Performance Type Filter Tests
    
    func testLivePerformance() {
        let testCases = [
            ("Track Title - Live", "Track Title"),
            ("Track Title - Live @ Moon", "Track Title"),
            ("Track Title (Live)", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.performanceType.live), expected)
        }
    }
    
    func testAcousticPerformance() {
        let testCases = [
            ("Track Title - Acoustic", "Track Title"),
            ("Track Title (Acoustic)", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.performanceType.acoustic), expected)
        }
    }
    
    // MARK: - Release Information Filter Tests
    
    func testRemasterFilter() {
        let testCases = [
            ("Track Title - Remastered", "Track Title"),
            ("Track Title (2015 Remaster)", "Track Title"),
            ("Track Title [Remastered]", "Track Title"),
            ("Track Title (Remastered 2009)", "Track Title"),
            ("Track Title - 2011 Remaster", "Track Title"),
            ("Track Title (Deluxe Remaster)", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.releaseInformation.remaster), expected)
        }
    }
    
    func testReissueFilter() {
        let testCases = [
            ("Album Title Re-issue", "Album Title"),
            ("Album Title (Reissue)", "Album Title"),
            ("Album Title [Re-issue + Bonus]", "Album Title"),
            ("Album Title (2005 Re-issue)", "Album Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.releaseInformation.reissue), expected)
        }
    }
    
    func testVersionFilter() {
        let testCases = [
            ("Track Title (Album Version)", "Track Title"),
            ("Track Title [Single Version]", "Track Title"),
            ("Track Title (Deluxe Edition)", "Track Title"),
            ("Track Title - Mono Version", "Track Title"),
            ("Track Title - Stereo Version", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.releaseInformation.version), expected)
        }
    }
    
    func testAnniversaryFilter() {
        let testCases = [
            ("Album Title (25th Anniversary)", "Album Title"),
            ("Album Title [30th Anniversary Remaster]", "Album Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.releaseInformation.anniversary), expected)
        }
    }
    
    func testSingleAndEPAlbumsFilter() {
        let testCases = [
            ("Album Title - Single", "Album Title"),
            ("Album Title - EP", "Album Title")
        ]
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.releaseInformation.ep, FilterDirectory.releaseInformation.single), expected)
        }
    }
    
    func testRemixAndEditFilter() {
        let testCases = [
            ("Song Title - DJ Remix", "Song Title"),
            ("Song Title (DJ Remix)", "Song Title"),
            ("Song Title [DJ Remix]", "Song Title"),
            ("Song Title - DJ Edit", "Song Title"),
            ("Song Title (DJ Edit)", "Song Title"),
            ("Song Title [DJ Edit]", "Song Title")
        ]
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.releaseInformation.remix), expected)
        }
    }
    
    // MARK: - Parody and Cover Filter Tests
    
    func testParodyFilter() {
        let testCases = [
            ("Party In the CIA (Parody of \"Party In The U.S.A.\" by Miley Cyrus)", "Party In the CIA"),
            ("White & Nerdy (Parody of \"Ridin'\" by Chamillionaire feat. Krayzie Bone)", "White & Nerdy")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.parodyAndCover.parody), expected)
        }
    }
    
    func testCoverFilter() {
        let testCases = [
            ("Hallelujah (Cover of \"Hallelujah\" by Leonard Cohen)", "Hallelujah"),
            ("All Along the Watchtower (Cover of \"All Along the Watchtower\" by Bob Dylan)", "All Along the Watchtower")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.parodyAndCover.cover), expected)
        }
    }
    
    // MARK: - Media Source Cleanup Filter Tests
    
    func testVideoIndicatorsFilter() {
        let testCases = [
            ("Track Title (Official Video)", "Track Title"),
            ("Track Title - Music Video", "Track Title"),
            ("Track Title [Video]", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.mediaSourceCleanup.videoIndicators), expected)
        }
    }
    
    func testAudioIndicatorsFilter() {
        let testCases = [
            ("Track Title (Official Audio)", "Track Title"),
            ("Track Title - Audio", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.mediaSourceCleanup.audioIndicators), expected)
        }
    }
    
    func testFileExtensionsFilter() {
        let testCases = [
            ("Track Title.mp3", "Track Title"),
            ("Track Title.wav", "Track Title"),
            ("Track Title.flac", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.mediaSourceCleanup.fileExtensions), expected)
        }
    }
    
    func testQualityIndicatorsFilter() {
        let testCases = [
            ("Track Title HD", "Track Title"),
            ("Track Title (HQ)", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.mediaSourceCleanup.qualityIndicators), expected)
        }
    }
    
    func testDateYearInformationFilter() {
        let testCases = [
            ("Track Title (2021)", "Track Title"),
            ("Track Title [1999]", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.mediaSourceCleanup.dateYearInformation), expected)
        }
    }
    
    func testFullAlbumFilter() {
        let testCases = [
            ("Album Title Full Album", "Album Title"),
            ("Artist Name - Full Album", "Artist Name")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.mediaSourceCleanup.fullAlbum), expected)
        }
    }
    
    // MARK: - Lyrics and Language Filter Tests
    
    func testLyricsIndicatorsFilter() {
        let testCases = [
            ("Track Title (Lyric Video)", "Track Title"),
            ("Track Title (With Lyrics)", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.lyricsAndLanguage.lyricsIndicators), expected)
        }
    }
    
    func testLanguageSubtitlesFilter() {
        let testCases = [
            ("Track Title Sub Español", "Track Title"),
            ("Track Title (Letra)", "Track Title"),
            ("Track Title (En vivo)", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.lyricsAndLanguage.languageSubtitles), expected)
        }
    }
    
    // MARK: - Text Normalization Filter Tests
    
    func testHtmlEntitiesFilter() {
        let testCases = [
            ("Artist 1 &amp; Artist 2", "Artist 1 & Artist 2"),
            ("Track Title &#039;", "Track Title '")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.textNormalization.htmlEntities), expected)
        }
    }
    
    func testZeroWidthCharactersFilter() {
        let testCases = [
            ("Track\u{200B}Title", "TrackTitle"),
            ("\u{FEFF}Track Title", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.textNormalization.zeroWidthCharacters), expected)
        }
    }
    
    func testNonBreakingSpacesFilter() {
        let testCases = [
            ("Track\u{00A0}Title", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.textNormalization.nonBreakingSpaces), expected)
        }
    }
    
    func testSmartQuotesFilter() {
        let testCases = [
            ("Track \u{201C}Title\u{201D}", "Track \"Title\""),
            ("Track \u{2018}Title\u{2019}", "Track 'Title'")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.textNormalization.smartQuotes), expected)
        }
    }
    
    // MARK: - Formatting Standardization Filter Tests
    
    func testFeaturingArtistFormatFilter() {
        let testCases = [
            ("Track (feat. Artist)", "Track"),
            ("Track [ft. Artist]", "Track")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.formattingStandardization.featuringArtistFormat), expected)
        }
    }
    
    func testParenthesesBracketsFilter() {
        let testCases = [
            ("Track (Additional Info)", "Track"),
            ("Track [Additional Info]", "Track")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.formattingStandardization.parenthesesBrackets), expected)
        }
    }
    
    // MARK: - Miscellaneous Cleanup Filter Tests
    
    func testSpecificSuffixesFilter() {
        let testCases = [
            ("Track (Album Track)", "Track"),
            ("Track (Single)", "Track"),
            ("Track (Album)", "Track")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.miscellaneousCleanup.specificSuffixes), expected)
        }
    }
    
    func testLeadingTrailingPunctuationFilter() {
        let testCases = [
            ("...Track Title", "Track Title"),
            ("Track Title...", "Track Title")
        ]
        
        for (input, expected) in testCases {
            XCTAssertEqual(cleaner.apply(input, filter: FilterDirectory.miscellaneousCleanup.leadingTrailingPunctuation), expected)
        }
    }
}
