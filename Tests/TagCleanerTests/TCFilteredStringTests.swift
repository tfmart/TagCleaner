// TCFilteredStringTests.swift

import XCTest
@testable import TagCleaner

final class TCFilteredStringTests: XCTestCase {
    func testSingleFilter() {
        struct TestStruct {
            @TCFilteredString(filters: FilterDirectory.releaseInformation.remaster)
            var title: String = ""
        }
        
        let test = TestStruct(title: "Song Title (Remastered 2021)")
        XCTAssertEqual(test.title, "Song Title")
    }
    
    func testMultipleFilters() {
        struct TestStruct {
            @TCFilteredString(filters:
                FilterDirectory.releaseInformation.remaster,
                FilterDirectory.artistInformation.featuredArtists
            )
            var title: String = ""
        }
        
        let test = TestStruct(title: "Song Title (Remastered 2021) [feat. Another Artist]")
        XCTAssertEqual(test.title, "Song Title")
    }
    
    func testSettingNewValue() {
        struct TestStruct {
            @TCFilteredString(filters: FilterDirectory.releaseInformation.remaster)
            var title: String = ""
        }
        
        var test = TestStruct(title: "Original Title")
        test.title = "New Song (Remastered 2022)"
        XCTAssertEqual(test.title, "New Song")
    }
    
    func testEmptyString() {
        struct TestStruct {
            @TCFilteredString(filters: FilterDirectory.releaseInformation.remaster)
            var title: String = ""
        }
        
        let test = TestStruct(title: "")
        XCTAssertEqual(test.title, "")
    }
    
    func testNoMatchingFilter() {
        struct TestStruct {
            @TCFilteredString(filters: FilterDirectory.releaseInformation.remaster)
            var title: String = ""
        }
        
        let test = TestStruct(title: "Clean Song Title")
        XCTAssertEqual(test.title, "Clean Song Title")
    }
}
