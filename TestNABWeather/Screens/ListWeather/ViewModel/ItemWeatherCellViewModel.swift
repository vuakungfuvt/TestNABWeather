//
//  ItemWeatherCellViewModel.swift
//  TestNABWeather
//
//  Created by tungphan on 31/03/2022.
//

import UIKit

struct ItemWeatherCellViewModel {
    var date: Date
    var averageTemp: Int
    var pressure: Int
    var humidity: Int
    var description: String
    var mainWeather: MainWeather
    var fontSize: Int
    var nameTempUnit: String
    var imageUrl: String
}
