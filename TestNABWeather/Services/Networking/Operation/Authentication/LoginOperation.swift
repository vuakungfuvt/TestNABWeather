//
//  LoginOperation.swift
//  F99_Shiper
//
//  Created by Phùng Chịnh on 9/3/20.
//  Copyright © 2020 F99. All rights reserved.
//

import Foundation

class LoginOperation: BaseOperation<UserAccessToken> {
    
    override var baseURL: String {
        return Constants.Router.identity
    }
    
    override var path: String {
        return "connect/token"
    }
    
    override var method: HTTPRequestMethod {
        return .post
    }
    
    init(username: String,
         password: String,
         completion: @escaping (Result<UserAccessToken, APIError>) -> Void) {
        
        let params = ["username" : username,
                      "password" : password,
                      "grant_type" : "password",
                      "client_id" : "Angular",
                      "client_secret" : "democlient",
                     ]
        
        super.init(encodingType: .url,
                   urlParameters: params,
                   bodyParameters: [:],
                   maximumRetryCount: 0,
                   decodingStrategy: .normal,
                   completionQueue: .main,
                   completion: completion)
    }
    
}
