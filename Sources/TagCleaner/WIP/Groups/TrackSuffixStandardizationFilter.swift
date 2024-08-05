//
//  TrackSuffixStandardizationFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct TrackSuffixStandardizationFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.remix.regex
            Subgroups.edit.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case remix
        case edit
        
        public var regex: some RegexComponent {
            switch self {
            case .remix:
                Regex {
                    " - "
                    Capture {
                        OneOrMore(.any)
                    }
                    " "
                    ChoiceOf {
                        "Remix"
                        "Mix"
                    }
                }
                .ignoresCase()
            case .edit:
                Regex {
                    " - "
                    Capture {
                        OneOrMore(.any)
                    }
                    " Edit"
                }
                .ignoresCase()
            }
        }
        
        public func replace(_ input: String) -> String {
            input.replacing(regex) { match in
                "(\(match.output) \(self == .remix ? "Remix" : "Edit"))"
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let remix: Subgroups = .remix
    public let edit: Subgroups = .edit
}
