//
//  AlertCustomViewController.swift
//  TestNABWeather
//
//  Created by tungphan on 02/04/2022.
//

import Foundation

protocol SessionBuilder {
    var session: URLSession { get }
}

extension SessionBuilder {
    var session: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        return URLSession(configuration: config)
    }
}
