//
//  Chapter70_NSAttributedStringUITestsLaunchTests.swift
//  Chapter70_NSAttributedStringUITests
//
//  Created by 小鍋涼太 on 2021/10/05.
//

import XCTest

class Chapter70_NSAttributedStringUITestsLaunchTests: XCTestCase {

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
