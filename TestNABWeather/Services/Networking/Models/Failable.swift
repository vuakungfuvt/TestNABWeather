//
//  Failable.swift
//  TestNABWeather
//
//  Created by tungphan on 02/04/2022.
//

import Foundation

struct Failable<T: Decodable>: Decodable {
    let result: Result<T, APIError>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            let data = try container.decode(T.self)
            result = .success(data)
        } catch let err {
            result = .failure(.parsingError(err))
        }
    }
}

extension KeyedDecodingContainer {
    func decodeFailableArray<E: Decodable>(element type: E.Type, for key: K) throws -> [E] {
        let content = try decode([Failable<E>].self, forKey: key)
        return content.map { $0.result.value }.compactMap { $0 }
    }
}

extension Result {
    var value: Success? {
        switch self {
        case .success(let data):
            return data
        case .failure:
            return nil
        }
    }
    
    var error: Failure? {
        switch self {
        case .success:
            return nil
        case .failure(let err):
            return err
        }
    }
}
