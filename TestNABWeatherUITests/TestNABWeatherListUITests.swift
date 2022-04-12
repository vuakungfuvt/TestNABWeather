//
//  TestNABWeatherUITests.swift
//  TestNABWeatherUITests
//
//  Created by tungphan on 31/03/2022.
//

import XCTest
@testable import TestNABWeather

class TestNABWeatherUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableViewCellCount() throws {
                        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let _ = app.wait(for: .runningForeground, timeout: 5)
        let textField = app.textFields["tf_search"]
        textField.tap()
        textField.clearAndEnterText(text: "hanoi")
                
        
        let _ = app.wait(for: .runningBackground, timeout: 5)
        let tableView = app.tables.matching(identifier: "table_weather")
        XCTAssertGreaterThan(tableView.cells.count, 0)
                
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testBlankDataCells() throws {
        let app = XCUIApplication()
        app.launch()

        let _ = app.wait(for: .runningForeground, timeout: 5)
        let textField = app.textFields["tf_search"]
        textField.tap()
        textField.clearAndEnterText(text: "adefgbhtrews")
        let _ = app.wait(for: .runningBackground, timeout: 5)
        let tableView = app.tables.matching(identifier: "table_weather")
        XCTAssertEqual(tableView.cells.count, 0)
    }
    
    func testAlertWhenDoNotResult() throws {
        let app = XCUIApplication()
        app.launch()

        let _ = app.wait(for: .runningForeground, timeout: 5)
        let textField = app.textFields["tf_search"]
        textField.tap()
        textField.clearAndEnterText(text: "adefgbhtrews")
        let _ = app.wait(for: .runningBackground, timeout: 5)
        let view = app.otherElements["viewAlert"]
        XCTAssertTrue(view.exists)
    }
    
    func testButtonCancelTap() throws {
        let app = XCUIApplication()
        app.launch()

        let _ = app.wait(for: .runningForeground, timeout: 5)
        let textField = app.textFields["tf_search"]
        let button = app.buttons["btnCancel"]
        button.tap()
        let text = textField.value as! String
        XCTAssertEqual(text.count, 0)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
