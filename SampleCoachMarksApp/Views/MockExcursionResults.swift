//
//  MockExcursionResults.swift
//  SampleCoachMarksApp
//
//  Created by Aashiq Mortimer on 19/06/2024.
//

import Foundation
import SwiftUI

struct MockExcursionResults: View {
    
    @CoachMark(key: "EAT-Shortlist", threshold: 4) var showCoachMark
    
    var body: some View {
        ScrollView {
            
            // resetCoachMark method is to enable button for demo purposes only.
            
            Button(action: {
                $showCoachMark.resetCoachMarks()
            }, label: {
                Text("Reset CoachMarks")
            })
            .buttonStyle(.borderedProminent)
            .foregroundStyle(.white)
            
            ForEach(0..<11, id: \.self) { index in
                SearchCard(coachMark: _showCoachMark, isEnabled: index == 1)
                    .onAppear(perform: {
                        if index == 10 {
                            print("View: \($showCoachMark.viewCounts)")
                            print("Interaction: \($showCoachMark.interactionFlags)")
                        }
                    })
            }
        }
        .onAppear {
            $showCoachMark.incrementViewCount(for: _showCoachMark)
        }
    }
}

struct SearchCard: View {
    
    @State var shortlistIconTapped: Bool = false
    
    var coachMark: CoachMark?
    var isEnabled: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                Button {
                    shortlistIconTapped.toggle()
                    if let coach = coachMark {
                        coach.projectedValue.setInteraction(for: coach)
                    }
                } label: {
                    Image(systemName: shortlistIconTapped ? "heart.fill" : "heart")
                        .resizable()
                }
                .frame(width: 50, height: 50)
                .coachMark(coachMarkStorage: coachMark,
                           title: Constants.shortlistTitle,
                           message: Constants.shortlistMessage,
                           buttonText: Constants.buttonText,
                           indexEnabled: isEnabled)
            }
            
            Text("Eiffel Tower")
        }
        .padding()
        .border(.red)
    }
    
    struct Constants {
        static let shortlistTitle = "Add to your shortlist"
        static let shortlistMessage = "You can save and compare your favourite experiences by adding them to your shortlist"
        static let buttonText = "Got it"
    }
}
