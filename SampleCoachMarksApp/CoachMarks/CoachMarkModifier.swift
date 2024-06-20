//
//  CoachMarkModifier.swift
//  SampleCoachMarksApp
//
//  Created by Aashiq Mortimer on 19/06/2024.
//

import Foundation
import SwiftUI

struct CoachMarkModifier: ViewModifier {
    let coachMarkStorage: CoachMark?
    let title: String
    let message: String
    let buttonText: String
    let indexEnabled: Bool
    private var shouldShowCoachMark: Bool {
        coachMarkStorage?.wrappedValue ?? false
    }

    func body(content: Content) -> some View {
        if let coachMark = coachMarkStorage, #available(iOS 16.4, *), indexEnabled {
            content
                .popover(isPresented: .constant(shouldShowCoachMark), content: {
                    CoachMarkView(title: title, message: message, buttonText: buttonText, storage: coachMark)
                        .presentationCompactAdaptation(.popover)
                        .presentationBackground(.white)
                        .interactiveDismissDisabled()
                })
        } else {
            content
        }
    }
}

extension View {
    func coachMark(coachMarkStorage: CoachMark?, title: String, message: String, buttonText: String, indexEnabled: Bool) -> some View {
        modifier(CoachMarkModifier(coachMarkStorage: coachMarkStorage, title: title, message: message, buttonText: buttonText, indexEnabled: indexEnabled))
    }
}
