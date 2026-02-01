import XCTest
@testable import TagCleaner

final class NestedBracketsTests: XCTestCase {
    let cleaner = TagCleaner()

    // MARK: - Featured Artists

    func testFeaturedArtistsWithTrailingBrackets() {
        let input = "Stay (feat. Tim Atlas) [Remastered 2023]"
        let result = cleaner.apply(input, filter: FilterDirectory.artistInformation.featuredArtists)
        XCTAssertEqual(result, "Stay [Remastered 2023]")
    }

    func testFeaturedArtistsSimple() {
        let input = "Stay (feat. Tim Atlas)"
        let result = cleaner.apply(input, filter: FilterDirectory.artistInformation.featuredArtists)
        XCTAssertEqual(result, "Stay")
    }

    func testFeaturedArtistsWithDashSuffix() {
        let input = "Stay (ft. Someone) - Radio Edit"
        let result = cleaner.apply(input, filter: FilterDirectory.artistInformation.featuredArtists)
        XCTAssertEqual(result, "Stay - Radio Edit")
    }

    // MARK: - Anniversary and Remaster

    func testAnniversaryAndRemasterMultipleGroups() {
        let input = "Travelling Without Moving (20th Anniversary Edition) [2016 Remaster]"
        let result = cleaner.apply(input, filter:
            FilterDirectory.releaseInformation.anniversary,
            FilterDirectory.releaseInformation.remaster
        )
        XCTAssertEqual(result, "Travelling Without Moving")
    }

    func testAnniversaryAlone() {
        let input = "Album (25th Anniversary Edition)"
        let result = cleaner.apply(input, filter: FilterDirectory.releaseInformation.anniversary)
        XCTAssertEqual(result, "Album")
    }

    func testRemasterAlone() {
        let input = "Song [2016 Remaster]"
        let result = cleaner.apply(input, filter: FilterDirectory.releaseInformation.remaster)
        XCTAssertEqual(result, "Song")
    }

    // MARK: - Multiple Groups

    func testVersionAndRemasterMultipleGroups() {
        let input = "Song Title [Deluxe Edition] (Remastered)"
        let result = cleaner.apply(input, filter:
            FilterDirectory.releaseInformation.version,
            FilterDirectory.releaseInformation.remaster
        )
        XCTAssertEqual(result, "Song Title")
    }

    func testBonusTrackAndRemasterMultipleGroups() {
        let input = "Track (Bonus) [2020 Remaster]"
        let result = cleaner.apply(input, filter:
            FilterDirectory.releaseInformation.bonusTrack,
            FilterDirectory.releaseInformation.remaster
        )
        XCTAssertEqual(result, "Track")
    }

    func testFeaturedArtistsInBrackets() {
        let input = "Song [feat. Artist] (Live)"
        let result = cleaner.apply(input, filter: FilterDirectory.artistInformation.featuredArtists)
        XCTAssertEqual(result, "Song (Live)")
    }
}
