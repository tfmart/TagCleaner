//
//  TagCleaner.swift
//
//
//  Created by Tomas Martins on 04/12/23.
//

import Foundation

/// A struct that provides functionality to clean music metadata tags.
public struct TagCleaner {
    /// Applies one or more filters to the input string.
    ///
    /// This method takes an input string and one or more filters, applies the filters to the input
    /// in the order they are provided, and returns the cleaned result. It also trims any leading
    /// or trailing whitespace from the result.
    ///
    /// - **Parameters**:
    ///   - input: The string to be cleaned.
    ///   - filter: One or more objects conforming to `TCFilterApplier` that define the cleaning rules.
    ///
    /// - **Returns**: The cleaned string with leading and trailing whitespace removed.
    ///
    /// - Example using a single filter:
    ///   ```swift
    ///   let cleaner = TagCleaner()
    ///   let input = "Song Title (Remastered 2021)"
    ///   let result = cleaner.apply(input, filter: FilterDirectory.releaseInformation.remaster)
    ///   print(result) // Prints: "Song Title"
    ///   ```
    ///
    /// - Example using multiple filters:
    ///   ```swift
    ///   let cleaner = TagCleaner()
    ///   let input = "Song Title (Remastered 2021) [feat. Another Artist]"
    ///   let result = cleaner.apply(input,
    ///                              filter: FilterDirectory.releaseInformation.remaster,
    ///                                      FilterDirectory.artistInformation.featuredArtists)
    ///   print(result) // Prints: "Song Title"
    ///   ```
    ///
    /// - Note: Filters are applied in the order they are provided. The output of each filter
    ///   becomes the input for the next filter in the sequence.
    public func apply(_ input: String, filter: any TCFilterApplier...) -> String {
        var result = input
        for filter in filter {
            result = filter.replace(result)
        }
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
