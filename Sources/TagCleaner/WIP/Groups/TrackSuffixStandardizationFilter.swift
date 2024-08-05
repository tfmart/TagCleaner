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
                    "-"
                    OneOrMore(.whitespace)
                    Capture {
                        OneOrMore(.any)
                    }
                    OneOrMore(.whitespace)
                    ChoiceOf {
                        "Remix"
                        "Mix"
                    }
                }
                .ignoresCase()
            case .edit:
                Regex {
                    "-"
                    OneOrMore(.whitespace)
                    Capture {
                        OneOrMore(.any)
                    }
                    OneOrMore(.whitespace)
                    "Edit"
                }
                .ignoresCase()
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let remix: Subgroups = .remix
    public let edit: Subgroups = .edit
}
