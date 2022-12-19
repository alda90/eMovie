//
//  ActionGroup.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import Foundation

struct ActionGroup: Hashable {
    let title: String
    let action: TypeAction
    let style:  TypeStyle
    
    enum TypeAction {
        case language
        case year
    }
    
    enum TypeStyle {
        case light
        case dark
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: ActionGroup, rhs: ActionGroup) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
}
