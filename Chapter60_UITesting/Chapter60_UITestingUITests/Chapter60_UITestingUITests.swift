//
//  Chapter60_UITestingUITests.swift
//  Chapter60_UITestingUITests
//
//  Created by 小鍋涼太 on 2021/09/25.
//

import XCTest

// §60.1 Accessibility identifier
class Chapter60_UITestingUITests: XCTestCase {

    private let app = XCUIApplication()
    private var view: XCUIElement!
    private var addButton: XCUIElement!
    
    override func setUp() {
        super.setUp()
        
        // §60.3 Disable animations during UI Testing
        app.launchEnvironment = ["animations": "0"]
        app.launch()
        // ここらへんのプロパティが、UIKitのパーツによって違うので注意
        // otherElementsの場合、accessibilityIdentifierをkeyPathに設定する必要がある。
        view = app.otherElements["view"]
        addButton = app.buttons["addButton"]
    }
    
    func testMyApp() {
        // §60.5 Rotate devices
        XCUIDevice.shared.orientation = .landscapeLeft
        addButton.tap()
        view.tap()
    }
    
    // §60.4 Launch and Terminate application while executing
    func testTerminating() {
        app.terminate()
    }
}
