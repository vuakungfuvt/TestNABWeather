//
//  DataContainer.swift
//  TestNABWeather
//
//  Created by tungphan on 02/04/2022.
//

import Foundation

struct DataContainer<T: Decodable>: Decodable {
    let data: T
}
