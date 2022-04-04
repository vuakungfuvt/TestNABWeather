//
//  ListWeatherTest.swift
//  TestNABWeatherTests
//
//  Created by tungphan on 01/04/2022.
//

import XCTest
@testable import TestNABWeather

class ListWeatherTest: XCTestCase {
    
    var viewModel: ListWeatherViewModel!
    
    override func setUp() {
        viewModel = ListWeatherViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testLoadingWhenCallingCity() {
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        viewModel.updateLoadingStatus = { [weak viewModel] in
            loadingStatus = viewModel!.isLoading
            expect.fulfill()
        }
        viewModel.getCityEntity(q: "saigon")
        // Assert
        XCTAssertTrue( loadingStatus )
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testTotalItemWhenFetchCity() {
        let count = 7
        Configuration.shared.setting.countDay = count
        var numberOfElements = 0
        let expect = XCTestExpectation(description: "Loading status updated")
        viewModel.updateFetchingCity = { [weak viewModel] in
            numberOfElements = viewModel?.itemWeatherCellViewModels.count ?? 0
            // Assert
            XCTAssertTrue( numberOfElements == count )
            expect.fulfill()
        }
        viewModel.getCityEntity(q: "saigon")
        
        wait(for: [expect], timeout: 3.0)
    }
    
    func testGetCellViewModel() {
        let count = 7
        Configuration.shared.setting.countDay = count
        let expect = XCTestExpectation(description: "Loading status updated")
        viewModel.updateFetchingCity = { [weak viewModel] in
            let indexPath = IndexPath(row: 1, section: 0)
            let cellVM = viewModel?.getCellViewModel(at: indexPath)
            XCTAssertEqual(cellVM?.description, viewModel?.city?.list[indexPath.row].weather.first?.weatherDescription)
            expect.fulfill()
        }
        viewModel.getCityEntity(q: "saigon")
        
        wait(for: [expect], timeout: 3.0)
    }
    
    func testAllCellViewModels() {
        let count = 7
        Configuration.shared.setting.countDay = count
        let expect = XCTestExpectation(description: "Loading status updated")
        viewModel.updateFetchingCity = { [weak viewModel] in
            for index in 0 ..< (viewModel?.city?.list.count ?? 0) {
                let indexPath = IndexPath(row: index, section: 0)
                let cellVM = viewModel?.getCellViewModel(at: indexPath)
                let dt = (cellVM?.date.millisecondsSince1970 ?? 0) / 1000
                XCTAssertEqual(Int(dt), viewModel?.city?.list[indexPath.row].dt)
                
                let temp = viewModel?.city?.list[indexPath.row].temp.getAveragerTemp() ?? 0
                XCTAssertEqual(cellVM?.averageTemp, Int(temp))
                
                XCTAssertEqual(cellVM?.humidity, viewModel?.city?.list[indexPath.row].humidity)
                
                XCTAssertEqual(cellVM?.description, viewModel?.city?.list[indexPath.row].weather.first?.weatherDescription)
                
                let icon = viewModel?.city?.list[indexPath.row].weather.first?.icon ?? "10d"
                let imageUrl = "http://openweathermap.org/img/w/\(icon).png"
                XCTAssertEqual(cellVM?.imageUrl, imageUrl)
                
                XCTAssertEqual(cellVM?.fontSize, Configuration.shared.setting.fontSize)
            }
            expect.fulfill()
        }
        viewModel.getCityEntity(q: "saigon")
        
        wait(for: [expect], timeout: 3.0)
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

}
