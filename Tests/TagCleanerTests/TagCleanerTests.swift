import XCTest
import RegexBuilder
@testable import TagCleaner

final class TagCleanerTests: XCTestCase {
    var tagCleaner: TagCleaner = .init()
    
    func testCleanExplicitFilter() {
        let explicitInput = "One More Night (Explicit)"
        var filteredOutput = tagCleaner.removeCleanExplicit(from: explicitInput)
        
        XCTAssertNotEqual(explicitInput, filteredOutput)
        XCTAssertEqual(filteredOutput, "One More Night")
    }
    
    func testCleanFilter() {
        let cleanInput = "One More Night (Clean)"
        var filteredOutput = tagCleaner.removeCleanExplicit(from: cleanInput)
        
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
