//
//  CoachMarksUserDefaultsTests.swift
//  SampleCoachMarksAppTests
//
//  Created by Aashiq Mortimer on 19/06/2024.
//

import XCTest
@testable import SampleCoachMarksApp

final class CoachMarksUserDefaultsTests: XCTestCase {
    var coachMarksUserDefaults: CoachMarksUserDefaults!
    var userDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: "TestSuite")
        userDefaults.removePersistentDomain(forName: "TestSuite")
        coachMarksUserDefaults = CoachMarksUserDefaults(defaults: userDefaults)
    }
    
    override func tearDown() {
        userDefaults.removePersistentDomain(forName: "TestSuite")
        userDefaults = nil
        coachMarksUserDefaults = nil
        super.tearDown()
    }
    
    func testInitialisedValues() {
        let coachMark = CoachMark(key: "test", threshold: 0, userDefaults: coachMarksUserDefaults)
        XCTAssertFalse(coachMarksUserDefaults.interactionFlags[coachMark.interactionFlagKey, default: false])
        XCTAssertEqual(coachMarksUserDefaults.viewCounts[coachMark.viewCountKey, default: 0], 0)
    }
    
    func testIncrementViewCount() {
        let coachMark = CoachMark(key: "test", threshold: 0, userDefaults: coachMarksUserDefaults)
        coachMarksUserDefaults.incrementViewCount(for: coachMark)
        XCTAssertEqual(coachMarksUserDefaults.viewCounts[coachMark.viewCountKey, default: 0], 1)
        XCTAssertTrue(((userDefaults.dictionary(forKey: "coachMarks")?.keys.contains("test_viewCount")) != nil))
    }
    
    func testSetInteraction() {
        let coachMark = CoachMark(key: "test", threshold: 0, userDefaults: coachMarksUserDefaults)
        coachMarksUserDefaults.setInteraction(for: coachMark)
        XCTAssertTrue(coachMarksUserDefaults.interactionFlags[coachMark.interactionFlagKey, default: false])
        XCTAssertTrue(((userDefaults.dictionary(forKey: "coachMarks")?.keys.contains("test_interactionFlag")) != nil))
    }
    
    func testResetCoachMarks() {
        let coachMark = CoachMark(key: "test", threshold: 0, userDefaults: coachMarksUserDefaults)
        coachMarksUserDefaults.incrementViewCount(for: coachMark)
        coachMarksUserDefaults.setInteraction(for: coachMark)
        coachMarksUserDefaults.resetCoachMarks()
        XCTAssertEqual(coachMarksUserDefaults.viewCounts[coachMark.viewCountKey, default: 0], 0)
        XCTAssertFalse(coachMarksUserDefaults.interactionFlags[coachMark.interactionFlagKey, default: false])
    }
    
    func testWrappedValueReturnsFalseInitially() {
        let coachMark = CoachMark(key: "myKey", threshold: 2, userDefaults: coachMarksUserDefaults)
        XCTAssertFalse(coachMark.wrappedValue)
    }
    
    func testWrappedValueReturnsTrueAfterThresholdMet() {
        let coachMark = CoachMark(key: "myKey", threshold: 2, userDefaults: coachMarksUserDefaults)
        for _ in 0..<2 { // Increment view count twice
            coachMarksUserDefaults.incrementViewCount(for: coachMark)
        }
        XCTAssertTrue(coachMark.wrappedValue)
    }
    
    func testWrappedValueHidesAfterInteraction() {
        let coachMark = CoachMark(key: "myKey", threshold: 2, userDefaults: coachMarksUserDefaults)
        for _ in 0..<2 { // Increment view count twice
            coachMarksUserDefaults.incrementViewCount(for: coachMark)
        }
        coachMarksUserDefaults.setInteraction(for: coachMark)
        XCTAssertFalse(coachMark.wrappedValue)
    }
}
