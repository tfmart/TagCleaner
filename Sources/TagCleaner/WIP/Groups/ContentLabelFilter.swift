//
//  ContentLabelFilter.swift
//
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct ContentLabelFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.explicit.regex
            Subgroups.clean.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case explicit
        case clean
        
        var regex: some RegexComponent {
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
    
    static var explicit: Subgroups = .explicit
    static var clean: Subgroups = .clean
}
