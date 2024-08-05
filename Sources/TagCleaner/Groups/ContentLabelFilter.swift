//
//  ContentLabelFilter.swift
//
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

/// A filter for removing content labels from titles.
/// This filter group includes subfilters for:
/// - Explicit content labels (e.g., "[Explicit]", "(Explicit)")
/// - Clean content labels (e.g., "[Clean]", "(Clean)")
public struct ContentLabelFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.explicit.regex
            Subgroups.clean.regex
        }
    }
    
    public enum Subgroups: TCFilterApplier, CaseIterable {
        case explicit
        case clean
        
        public var regex: some RegexComponent {
            switch self {
            case .explicit:
                Regex {
                    ChoiceOf {
                        "("
                        "["
                    }
                    "Explicit"
                    ChoiceOf {
                        ")"
                        "]"
                    }
                }
                .ignoresCase()
            case .clean:
                Regex {
                    ChoiceOf {
                        "("
                        "["
                    }
                    "Clean"
                    ChoiceOf {
                        ")"
                        "]"
                    }
                }
                .ignoresCase()
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    public let explicit: Subgroups = .explicit
    public let clean: Subgroups = .clean
}
