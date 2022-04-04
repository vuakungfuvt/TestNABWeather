//
//  DataContainer.swift
//  F99
//
//  Created by Linh Ta on 8/12/20.

//

import Foundation

struct DataContainer<T: Decodable>: Decodable {
    let data: T
}
