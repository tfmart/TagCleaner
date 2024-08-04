# TagCleaner

TagCleaner is a Swift package that provides a robust solution for cleaning and standardizing music metadata tags. It offers a set of filters to remove common extraneous information from song titles, album names, and other music-related text.

## Features

- Multiple built-in filters for common tag cleaning tasks
- Customizable filter application
- Easy to use API
- Support for iOS, macOS, watchOS, and tvOS

## How It Works

TagCleaner is an experimental project that leverages Swift's RegexBuilder to clean music metadata. It's inspired by and based on the work of Web Scrobbler's metadata-filter (https://github.com/web-scrobbler/metadata-filter), adapting similar concepts to a native Swift implementation.

The package uses a combination of RegexBuilder patterns and Swift's string manipulation capabilities to clean music metadata. This approach allows for powerful and flexible text processing while taking advantage of Swift's type-safe regex creation.

TagCleaner includes filters for:

- Explicit/Clean labels
- Featured artists
- Remastered versions
- Reissues
- Remixes
- Singles and EPs
- Bonus tracks
- Live recordings
- Parodies
- Version information
- YouTube-specific tags
- Additional artists

You can apply all filters at once or selectively use specific filters as needed. The experimental nature of this project means it's continuously evolving, and we welcome feedback and contributions to improve its functionality and performance.

## Installation

TagCleaner can be installed using Swift Package Manager.

1. In Xcode, select "File" → "Swift Packages" → "Add Package Dependency"
2. Enter the repository URL: `https://github.com/yourusername/TagCleaner.git`
3. Select the version you want to use

Alternatively, you can add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/tfmart/TagCleaner.git", from: "1.0.0")
]
```

## Usage

Here's a basic example of how to use TagCleaner:

```swift
import TagCleaner

let cleaner = TagCleaner()
let cleanedTitle = cleaner.apply("Song Title (Remastered 2021) [feat. Another Artist]")
print(cleanedTitle) // Outputs: "Song Title"
```

You can also apply specific filters:

```swift
let cleanedTitle = cleaner.apply("Song Title (Remix) [feat. Another Artist]", filters: .remix, .featuredArtists)
print(cleanedTitle) // Outputs: "Song Title"
```

## System Requirements

- iOS 16.0+
- macOS 13.0+
- watchOS 9.0+
- tvOS 16.0+
- Swift 5.9+

## License

TagCleaner is released under the MIT License. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
