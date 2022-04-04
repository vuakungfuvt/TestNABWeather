//
//  ListWeatherViewModel.swift
//  TestNABWeather
//
//  Created by tungphan on 31/03/2022.
//

import UIKit

class ListWeatherViewModel: NSObject {
    
    private var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .background
        return queue
    }()
    
    var city: CityEntity?
    var searchedString: String = ""
    var reloadDataTableView: (() -> Void)?
    var loadErrorContent: ((_ errorContent: String) -> Void)?
    
    var itemWeatherCellViewModels = [ItemWeatherCellViewModel]() {
        didSet {
            self.reloadDataTableView?()
        }
    }
    
    var updateLoadingStatus: (()->())?
    var isLoading = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var updateFetchingCity: (()->())?
    
    func loadLocal() {
        if let cityEntity = Configuration.shared.getCityEntity() {
            self.fetchData(city: cityEntity)
        }
    }
    
    func getCityEntity(q: String) {
        searchedString = q
        let cnt: Int = Configuration.shared.setting.countDay
        let unit: UnitTemp = UnitTemp(rawValue: Configuration.shared.setting.unitTemp) ?? .Celsius
        self.isLoading = true
        let operation = ListWeatherOperation(q: q, cnt: cnt, unit: unit) { result in
            self.isLoading = false
            switch result {
            case .success(let city):
                self.fetchData(city: city)
                Configuration.shared.saveCity(city: city)
            case .failure(let error):
                self.loadErrorContent?(error.localizedDescription)
            }
        }
        operationQueue.addOperation(operation)
    }
    
    func fetchData(city: CityEntity) {
        var viewModels = [ItemWeatherCellViewModel]()
        city.list.forEach {
            let vm = createCellViewModel(listWeather: $0)
            viewModels.append(vm)
        }
        self.city = city
        self.itemWeatherCellViewModels = viewModels
        self.updateFetchingCity?()
    }
    
    func createCellViewModel(listWeather: ListWeather) -> ItemWeatherCellViewModel {
        let date = Date(milliseconds: Int64(listWeather.dt * 1000))
        let temp = Int(listWeather.temp.getAveragerTemp())
        let pressure = listWeather.pressure
        let humidity = listWeather.humidity
        let description = listWeather.weather.first?.weatherDescription ?? ""
        let main = listWeather.weather.first?.main ?? "Clouds"
        let mainWeather = MainWeather(rawValue: main) ?? .Clouds
        let unitTemp = UnitTemp(rawValue: Configuration.shared.setting.unitTemp) ?? .Celsius
        let icon = listWeather.weather.first?.icon ?? "10d"
        let imageUrl = "http://openweathermap.org/img/w/\(icon).png"
        return ItemWeatherCellViewModel(date: date, averageTemp: temp, pressure: pressure, humidity: humidity, description: description, mainWeather: mainWeather, fontSize: Configuration.shared.setting.fontSize, nameTempUnit: unitTemp.name, imageUrl: imageUrl)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ItemWeatherCellViewModel {
        return itemWeatherCellViewModels[indexPath.row]
    }
    
    func updatefontSize(fontSize: Int) {
        var viewModels = itemWeatherCellViewModels
        for index in 0 ..< itemWeatherCellViewModels.count {
            viewModels[index].fontSize = fontSize
        }
        self.itemWeatherCellViewModels = viewModels
    }
    
    func updateNumberCountDay(count: Int) {
        Configuration.shared.setting.countDay = count
        getCityEntity(q: searchedString)
    }
    
    func updateTempUnit(tempUnit: UnitTemp) {
        Configuration.shared.setting.unitTemp = tempUnit.rawValue
        getCityEntity(q: searchedString)
    }
}
