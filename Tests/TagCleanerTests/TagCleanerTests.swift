import XCTest
import RegexBuilder
@testable import TagCleaner

final class TagCleanerTests: XCTestCase {
    var tagCleaner: TagCleaner = .init()
    
    func testCleanExplicitFilter() {
        let explicitInput = "One More Night (Explicit)"
        let filteredOutput = tagCleaner.removeCleanExplicit(from: explicitInput)
        
        XCTAssertNotEqual(explicitInput, filteredOutput)
        XCTAssertEqual(filteredOutput, "One More Night")
    }
    
    func testCleanFilter() {
        let cleanInput = "One More Night (Clean)"
        let filteredOutput = tagCleaner.removeCleanExplicit(from: cleanInput)
        
        XCTAssertNotEqual(cleanInput, filteredOutput)
        XCTAssertEqual(filteredOutput, "One More Night")
    }
    
    func testFeatFilter() {
        let inputWithParentheses = "After the Storm (feat. Tyler, The Creator & Bootsy Collins)"
        let inputWithBrackets = "After the Storm [feat. Tyler, The Creator & Bootsy Collins]"
        let inputWithoutSeparator = "After the Storm feat. Tyler, The Creator & Bootsy Collins"
        
        let output1: String = tagCleaner.removeFeature(from: inputWithParentheses)
        let output2: String = tagCleaner.removeFeature(from: inputWithBrackets)
        let output3: String = tagCleaner.removeFeature(from: inputWithoutSeparator)
        
        XCTAssertEqual(output1, "After the Storm")
        XCTAssertEqual(output2, "After the Storm")
        XCTAssertEqual(output3, "After the Storm")
    }
    
    func testRemasteredFilter() {
        let inputData = [
            "Track Title",
            "Track Title - Remastered",
            "Track Title - Remastered 2015",
            "Track Title (Remastered 2009)",
            "Track Title (Remaster 2009)",
            "Track Title [2011 - Remaster]",
            "Track Title (2011 - Remaster)",
            "Track Title (2011 Remaster)",
            "Track Title - 2011 - Remaster",
            "Track Title - 2006 Remaster",
            "Track Title - 2006 Remastered",
            "Track Title - 2001 Digital Remaster",
            "Track Title - 2011 Remastered Version",
            "Track Title (Live / Remastered)",
            "Track Title - Live / Remastered",
            "Track Title (Remastered)",
            "Track Title [Remastered]",
            "Track Title (Deluxe Remaster)",
            "Track Title [Deluxe Remaster]",
            "Track Title (Remastered Deluxe Box Set)",
            "Track Title [Remastered Deluxe Box Set]",
            "Track Title (2014 Remastered Version)",
            "Track Title [2014 Remastered Version]",
            "Track Title (2009 Re-Mastered Digital Version)",
            "Track Title (2009 Remastered Digital Version)"
        ]


        for input in inputData {
            let output = tagCleaner.removeRemastered(from: input)
            XCTAssertEqual(output, "Track Title", "Failed on case: \(input)")
        }
    }
    
    func testReissueFilter() {
        let inputWithParentheses = "Album Title Re-issue"
        let inputWithBrackets = "Album Title [Whatever Re-issue Whatever]"
        let inputWithDash = "Album Title (Whatever Re-issue Whatever)"
        
        let output1: String = tagCleaner.removeReissue(from: inputWithParentheses)
        let output2: String = tagCleaner.removeReissue(from: inputWithBrackets)
        let output3: String = tagCleaner.removeReissue(from: inputWithDash)
        
        let expectation = "Album Title"
        
        XCTAssertEqual(output1, expectation)
        XCTAssertEqual(output2, expectation)
        XCTAssertEqual(output3, expectation)
    }
}
