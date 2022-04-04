//
//  APIError.swift
//  F99
//
//  Created by Linh Ta on 8/12/20.

//

import Foundation

enum APIError: Error, Equatable {
    case invalidResponse
    case requestFailed(Error)
    case invalidData
    case parsingError(Error)
    case failedToCreateRequest
    case failedToDecryptData
    case noNetworkConnection
    case encodingFailed
    case custom(code: Int, description: String)
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response."
        case .requestFailed(let err):
            return err.localizedDescription
        case .invalidData:
            return "Invalid data."
        case .parsingError(let err):
            return err.localizedDescription
        case .failedToCreateRequest:
            return "Failed to create request."
        case .failedToDecryptData:
            return "Failed to decrypt data."
        case .noNetworkConnection:
            return "Mất kết nối. Vui lòng thử lại sau."
        case let .custom(_, description):
            return description
        case .encodingFailed:
            return " Tạo URLRequest thất bại."
        }
    }
}
