//
//  ListWeatherOperation.swift
//  TestNABWeather
//
//  Created by tungphan on 31/03/2022.
//

import UIKit

enum UnitTemp: String {
    case Kelvin = "Unit Default"
    case Celsius = "metric"
    case Fahrenheit = "imperial"
    
    var name: String {
        switch self {
        case .Kelvin:
            return "°K"
        case .Celsius:
            return "°C"
        case .Fahrenheit:
            return "°F"
        }
    }
}

class ListWeatherOperation: BaseOperation<CityEntity> {
    override var path: String {
        return "forecast/daily"
    }
    
    override var method: HTTPRequestMethod {
        return .get
    }
    
    init(q: String, cnt: Int, unit: UnitTemp,
         completion: @escaping (Result<CityEntity, APIError>) -> Void) {
        let params = [
            "q": q,
            "cnt": cnt,
            "appid": "60c6fbeb4b93ac653c492ba806fc346d",
            "units": unit.rawValue
        ] as [String : Any]
        super.init(encodingType: .url,
                   urlParameters: params,
                   bodyParameters: [:],
                   maximumRetryCount: 0,
                   decodingStrategy: .normal,
                   completionQueue: .main,
                   completion: completion)
    }
}
