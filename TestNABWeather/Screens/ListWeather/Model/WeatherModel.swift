//
//  WeatherModel.swift
//  TestNABWeather
//
//  Created by tungphan on 31/03/2022.
//

import Foundation
import UIKit

enum MainWeather: String {
    case Clouds
    case Rain
    case Clear
    
    var imageWeather: UIImage? {
        switch self {
        case .Clouds:
            return UIImage(named: "ic-cloud")
        case .Rain:
            return UIImage(named: "ic-rain")
        case .Clear:
            return UIImage(named: "ic-sun")
        }
    }
}

// MARK: - CityEntity
struct CityEntity: Codable {
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [ListWeather]
    
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - ListWeather
struct ListWeather: Codable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg: Int
    let gust: Double
    let clouds: Int
    let pop: Double
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
    
    func getAveragerTemp() -> Double {
        return (min + max) / 2
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
