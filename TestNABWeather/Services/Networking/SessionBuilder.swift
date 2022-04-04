//
//  SessionBuilder.swift
//  F99
//
//  Created by tnu on 8/12/20.

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
