//
//  MainViewUITests.swift
//  UITests
//
//  Created by Paulo Vázquez Acosta on 18/5/22.
//

import XCTest
@testable import Cajut

class MainViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    // CHAL-2 - Initial Screen - Tap Join game button
    func test_given_screen_when_tap_join_game_button_then_navigate_to_correct_screen() {
        let joinButton = app.buttons["initial.joinbutton"]
        joinButton.tap()
        XCTAssert(app.buttons["joingame.startbutton"].exists)
    }
    
    // CHAL-3 - Initial Screen - Tap Create game button
    func test_given_screen_when_tap_create_game_button_then_navigate_to_correct_screen() {
        let createButton = app.buttons["initial.createbutton"]
        createButton.tap()
        XCTAssert(app.buttons["creategame.createbutton"].exists)
    }
}
