//
//  TCFilteredString.swift
//  TagCleaner
//
//  Created by Tomas Martins on 05/08/24.
//

import Foundation

/// A property wrapper that automatically applies specified filters to a string value.
///
/// This wrapper allows you to declare string properties that are automatically cleaned
/// using one or more `TCFilterApplier` filters whenever they are accessed.
///
/// - Example:
///   ```swift
///   struct Song {
///       @TCFilteredString(filters:
///           FilterDirectory.releaseInformation.remaster,
///           FilterDirectory.artistInformation.featuredArtists
///       )
///       var title: String
///   }
///
///   var song = Song(title: "Song Title (Remastered 2021) [feat. Another Artist]")
///   print(song.title) // Outputs: "Song Title"
///   ```
@propertyWrapper
public struct TCFilteredString {
    private var value: String
    private let filters: [any TCFilterApplier]
    
    /// The wrapped value that is automatically filtered when accessed.
    public var wrappedValue: String {
        get {
            let cleaner = TagCleaner()
            return cleaner.apply(value, filters: filters)
        }
        set {
            value = newValue
        }
    }
    
    /// Creates a new filtered string with the specified initial value and filters.
    ///
    /// - Parameters:
    ///   - wrappedValue: The initial string value.
    ///   - filters: One or more `TCFilterApplier` filters to apply to the string.
    public init(wrappedValue: String, filters: any TCFilterApplier...) {
        self.filters = filters
        let tagCleaner = TagCleaner()
        self.value = tagCleaner.apply(wrappedValue, filters: filters)
    }
}
