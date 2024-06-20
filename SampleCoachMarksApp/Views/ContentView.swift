//
//  ContentView.swift
//  SampleCoachMarksApp
//
//  Created by Aashiq Mortimer on 19/06/2024.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("CoachMarks Sample App")
                    .offset(y: -200)
                    .font(.title)
                
                Text("Tap on button below for Coach Marks Feature")
                    .offset(y: -50)
                    .font(.callout)
                
                NavigationLink(destination: MockExcursionResults()) {
                    Text("Excursion Search Results")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView()
}
