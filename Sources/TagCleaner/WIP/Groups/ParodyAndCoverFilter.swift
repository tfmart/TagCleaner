//
//  ParodyAndCoverFilter.swift
//  TagCleaner
//
//  Created by Tomas Martins on 04/08/24.
//

import RegexBuilder

public struct ParodyAndCoverFilter: TCFilterApplierGroup {
    public var regex: some RegexComponent {
        ChoiceOf {
            Subgroups.parody.regex
            Subgroups.cover.regex
        }
    }
    
    enum Subgroups: TCFilterApplier, CaseIterable {
        case parody
        case cover
        
        var regex: some RegexComponent {
            switch self {
            case .parody:
                Regex {
                    " (Parody of \""
                    OneOrMore(.any)
                    "\" by "
                    OneOrMore(.any)
                    ")"
                }
            case .cover:
                Regex {
                    " (Cover of \""
                    OneOrMore(.any)
                    "\" by "
                    OneOrMore(.any)
                    ")"
                }
            }
        }
    }
    
    public var subgroups: [any TCFilterApplier] { Subgroups.allCases }
    
    static var parody: Subgroups = .parody
    static var cover: Subgroups = .cover
}
