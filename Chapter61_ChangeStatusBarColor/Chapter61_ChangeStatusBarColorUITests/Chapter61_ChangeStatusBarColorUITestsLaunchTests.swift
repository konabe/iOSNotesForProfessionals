//
//  Chapter61_ChangeStatusBarColorUITestsLaunchTests.swift
//  Chapter61_ChangeStatusBarColorUITests
//
//  Created by 小鍋涼太 on 2021/09/25.
//

import XCTest

class Chapter61_ChangeStatusBarColorUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}