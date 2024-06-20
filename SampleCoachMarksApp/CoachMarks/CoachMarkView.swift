//
//  CoachMarkView.swift
//  SampleCoachMarksApp
//
//  Created by Aashiq Mortimer on 19/06/2024.
//

import Foundation
import SwiftUI

struct CoachMarkView: View {

    let title: String
    let message: String
    let buttonText: String
    let storage: CoachMark

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text(title)
                .font(Constants.titleFont)
                .foregroundStyle(Constants.messageColor)
            Text(message)
                .font(Constants.messageFont)
                .multilineTextAlignment(.center)
                .foregroundColor(Constants.messageColor)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            Button(buttonText) {
                storage.projectedValue.setInteraction(for: storage)
            }
            .buttonStyle(primaryButtonStyle)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(.white)
        .cornerRadius(12)
        .onDisappear(perform: {
            storage.projectedValue.setInteraction(for: storage)
        })
    }
    
    let primaryButtonStyle = PrimaryButton(
        backgroundColor: .blue,
        foregroundColor: Color(.white),
        font: Font.custom("Ambit-Bold", size: 18)
    )
    
    struct Constants {
        static let titleFont = Font.custom("AmbitBold", size: 17)
        static let messageFont = Font.custom("TUITypeLight-Regular", size: 17)
        static let messageColor = Color(red: 0.11, green: 0.07, blue: 0.36)
    }
}
