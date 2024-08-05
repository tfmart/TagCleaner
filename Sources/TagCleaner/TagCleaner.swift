//
//  TagCleaner.swift
//
//
//  Created by Tomas Martins on 04/12/23.
//

import Foundation

/// A struct that provides functionality to clean music metadata tags.
public struct TagCleaner {
    /// Applies a specific filter to the input string.
    ///
    /// This method takes an input string and a filter, applies the filter to the input,
    /// and returns the cleaned result. It also trims any leading or trailing whitespace
    /// from the result.
    ///
    /// - Parameters:
    ///   - input: The string to be cleaned.
    ///   - filter: An object conforming to `TCFilterApplier` that defines the cleaning rules.
    ///
    /// - Returns: The cleaned string with leading and trailing whitespace removed.
    ///
    /// - Example:
    ///   ```swift
    ///   let cleaner = TagCleaner()
    ///   let input = "Song Title (Remastered 2021)"
    ///   let result = cleaner.apply(input, filter: FilterDirectory.releaseInformation)
    ///   print(result) // Prints: "Song Title"
    ///   ```
    func apply(_ input: String, filter: any TCFilterApplier) -> String {
        let result = filter.replace(input)
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
