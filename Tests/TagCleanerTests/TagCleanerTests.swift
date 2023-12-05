import XCTest
import RegexBuilder
@testable import TagCleaner

final class TagCleanerTests: XCTestCase {
    func testCleanExplicitRule() {
        let explicitInput = "One More Night (Explicit)"
        
        var filteredOutput = explicitInput
        let rules = TCFilter.cleanExplicitFilterRules
        for rule in rules {
            filteredOutput = filteredOutput.replacing(rule.source, with: "")
        }
        
        XCTAssertNotEqual(explicitInput, filteredOutput)
        XCTAssertEqual(filteredOutput, "One More Night")
    }
    
    func testCleanRule() {
        let cleanInput = "One More Night (Clean)"
        var filteredOutput = cleanInput
        let rules = TCFilter.cleanExplicitFilterRules
        for rule in rules {
            filteredOutput = filteredOutput.replacing(rule.source, with: "")
        }
        
        XCTAssertNotEqual(cleanInput, filteredOutput)
        XCTAssertEqual(filteredOutput, "One More Night")
    }
    
    func testFeatRule() {
        let inputWithParentheses = "After the Storm (feat. Tyler, The Creator & Bootsy Collins)"
        let inputWithBrackets = "After the Storm [feat. Tyler, The Creator & Bootsy Collins]"
        let inputWithouSeparator = "After the Storm feat. Tyler, The Creator & Bootsy Collins"
        
        var output1: String = inputWithParentheses
        var output2: String = inputWithBrackets
        var output3: String = inputWithouSeparator
        
        let rules = TCFilter.featureFilterRules
        for rule in rules {
            output1 = output1.replacing(rule.source, with: "")
            output2 = output2.replacing(rule.source, with: "")
            output3 = output3.replacing(rule.source, with: "")
        }
        
        XCTAssertEqual(output1, "After the Storm")
        XCTAssertEqual(output2, "After the Storm")
        XCTAssertEqual(output3, "After the Storm")
    }
}
