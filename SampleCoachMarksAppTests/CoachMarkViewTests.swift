//
//  CoachMarkViewTests.swift
//  SampleCoachMarksAppTests
//
//  Created by Aashiq Mortimer on 20/06/2024.
//

import SnapshotTesting
import XCTest
import SwiftUI
@testable import SampleCoachMarksApp

final class CoachMarkViewTests: XCTestCase {
    
    func testCoachMarkView() {
        let view = CoachMarkView(title: "Title", message: "This is a coach mark", buttonText: "Got it", storage: CoachMark(key: "testKey", threshold: 0))
        
        assertSnapshot(of: view, as: .image)
    }
}
