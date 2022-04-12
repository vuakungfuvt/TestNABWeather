//
//  SettingTest.swift
//  TestNABWeatherTests
//
//  Created by tungphan on 08/04/2022.
//

import XCTest
@testable import TestNABWeather

class SettingTest: XCTestCase {
    
    var viewModel: SettingViewModel!
    
    override func setUp() {
        viewModel = SettingViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSettingModel() {
        let setting = viewModel.setting!
        if let savedSetting = Configuration.shared.getSetting() {
            XCTAssertEqual(savedSetting.countDay, setting.countDay)
            XCTAssertEqual(savedSetting.fontSize, setting.fontSize)
            XCTAssertEqual(savedSetting.unitTemp, setting.unitTemp)
        }
    }

}
