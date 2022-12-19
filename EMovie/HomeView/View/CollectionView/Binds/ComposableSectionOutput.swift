//
//  ComposableSectionOutput.swift
//  EMovie
//
//  Created by Aldair Carrillo on 18/12/22.
//

import Foundation
import Combine

struct ComposableSectionOutput {
    let callToAction = PassthroughSubject<Movie, Never>()
    let navigateTo = PassthroughSubject<ActionGroup.TypeAction, Never>()
}
