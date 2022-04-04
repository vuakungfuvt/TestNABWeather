//
//  RequestBuilder.swift
//  F99
//
//  Created by tnu on 8/12/20.
//

import Foundation
import Alamofire

protocol RequestBuilder {
    var baseURL: String { get }
    var method: HTTPRequestMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var encodingType: ParameterEncodingType { get }
    var request: URLRequest? { get }
    var urlParameters: [String: Any] { get }
    var bodyParameters: [String: Any] { get }
    var completeURL: URL { get }
}

extension URLRequest {
    static func requestWithoutEncoding(url: URL, parameters: [String: String]) -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return URLRequest(url: components.url!)
    }
    
    func requestWithJsonEncoding(parameters: [String: Any]) -> URLRequest? {
        guard let url = self.url else { return nil }
        var newRequest = URLRequest(url: url)

        guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return nil }
        newRequest.httpBody = data
        newRequest.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        return newRequest
    }
    
    static func requestWithURLEncoding(url: URL, parameters: [String: Any], method: HTTPRequestMethod) -> URLRequest? {
        
        var request = URLRequest(url: url)
        
        do {
            switch method {
            case .post, .put, .delete, .patch:
                request = try URLEncoding.httpBody.encode(request, with: parameters)
            case .get:
                request = try URLEncoding.queryString.encode(request, with: parameters)
            }
        } catch {
            return nil
        }
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }

    
    static func requestWithUrlAndJsonEncoding(url: URL, urlParameters: [String: Any], bodyParameters: [String: Any], method: HTTPRequestMethod) -> URLRequest? {
        return URLRequest
//            .requestWithURLEncoding(url: url, parameters: urlParameters)?
            .requestWithURLEncoding(url: url, parameters: urlParameters, method: method)?
            .requestWithJsonEncoding(parameters: bodyParameters)
    }
    
    static func requestWithFormData(url: URL, fieldParameters: [String: Any], dataParameters: [FormDataAttachmentInfo]) -> URLRequest? {
        var newRequest = URLRequest(url: url)
        let boundary = "Boundary-\(UUID().uuidString)"

        let httpBody = NSMutableData()

        for (key, value) in fieldParameters {
            httpBody.appendString(convertFormFields(key: key, value: value, boundary: boundary))
        }

        for info in dataParameters {
            httpBody.append(convertFileData(key: info.key,
                                            fileData: info.value,
                                            fileName: info.fileName,
                                            mimeType: info.mimeType,
                                            using: boundary))
        }
        
        httpBody.appendString("--\(boundary)--")
        
        newRequest.httpBody = httpBody as Data
        newRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        return newRequest
    }
    
    static func convertFormFields(key: String, value: Any, boundary: String) -> String {
        var result = "--\(boundary)\r\n"
        result += "Content-Disposition: form-data; name=\"\(key)\"\r\n"
        result += "\r\n"
        result += "\(value)\r\n"
        return result
    }
    
    static func convertFileData(key: String, fileData: Data, fileName: String, mimeType: String, using boundary: String) -> Data {
      let data = NSMutableData()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data as Data
    }
}
