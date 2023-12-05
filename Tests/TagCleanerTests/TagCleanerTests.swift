import XCTest
import RegexBuilder
@testable import TagCleaner

final class TagCleanerTests: XCTestCase {
    var tagCleaner: TagCleaner = .init()
    
    func testCleanExplicitRule() {
        let explicitInput = "One More Night (Explicit)"
        var filteredOutput = tagCleaner.removeCleanExplicit(from: explicitInput)
        
        XCTAssertNotEqual(explicitInput, filteredOutput)
        XCTAssertEqual(filteredOutput, "One More Night")
    }
    
    func testCleanRule() {
        let cleanInput = "One More Night (Clean)"
        var filteredOutput = tagCleaner.removeCleanExplicit(from: cleanInput)
        
        XCTAssertNotEqual(cleanInput, filteredOutput)
        XCTAssertEqual(filteredOutput, "One More Night")
    }
    
    func testFeatRule() {
        let inputWithParentheses = "After the Storm (feat. Tyler, The Creator & Bootsy Collins)"
        let inputWithBrackets = "After the Storm [feat. Tyler, The Creator & Bootsy Collins]"
        let inputWithouSeparator = "After the Storm feat. Tyler, The Creator & Bootsy Collins"
        
        var output1: String = tagCleaner.removeFeature(from: inputWithParentheses)
        var output2: String = tagCleaner.removeFeature(from: inputWithBrackets)
        var output3: String = tagCleaner.removeFeature(from: inputWithouSeparator)
        
        XCTAssertEqual(output1, "After the Storm")
        XCTAssertEqual(output2, "After the Storm")
        XCTAssertEqual(output3, "After the Storm")
    }
}
