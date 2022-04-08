//
//  BaseOperation.swift
//  TestNABWeather
//
//  Created by tungphan on 02/04/2022.
//


import Foundation

enum OperationState: String {
    case ready = "isReady"
    case executing = "isExecuting"
    case finished = "isFinished"
}

enum DecodingStrategy {
    case normal
    case requireDataInsideContainer
}

struct CommonRequestHeaders {
    static let applicationJSON = ["Content-Type": "application/json"]
    static let applicationURLFormEncoded = ["Content-Type": "application/x-www-form-urlencoded"]
}

class BaseOperation<T: Decodable>: Operation, Networkingable {
    
    private(set) var encodingType: ParameterEncodingType
    private(set) weak var task: URLSessionTask?
    private(set) var decodingStrategy: DecodingStrategy
    private var maximumRetryCount: Int
    private var completionHandler: ((Result<T, APIError>) -> Void)?
    private weak var completionQueue: DispatchQueue?
    
    var bodyParameters: [String: Any]
    var urlParameters: [String : Any]
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var method: HTTPRequestMethod {
        preconditionFailure("Subclass must override this property")
    }
    
    var path: String {
        preconditionFailure("Subclass must override this property")
    }
    
    init(encodingType: ParameterEncodingType,
         urlParameters: [String: Any] = [:],
         bodyParameters: [String: Any] = [:],
         maximumRetryCount: Int = 0,
         decodingStrategy: DecodingStrategy = .normal,
         completionQueue: DispatchQueue = .main,
         completion: @escaping ((Result<T, APIError>) -> Void) = { _ in }) {
        
        self.encodingType = encodingType
        self.urlParameters = urlParameters
        self.bodyParameters = bodyParameters
        self.maximumRetryCount = maximumRetryCount
        self.decodingStrategy = decodingStrategy
        self.completionQueue = completionQueue
        self.completionHandler = completion
    }
    
    private(set) var state: OperationState = .ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        } didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        if isCancelled && state != .executing {
            return true
        }
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        guard !isCancelled else {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        task?.cancel()
        task = nil
        super.cancel()
        state = .finished
    }
    
    override func main() {
        requestData()
    }
    
    private func requestData() {
        guard let request = self.request else {
            complete(.failure(.failedToCreateRequest))
            return
        }
        
        let newTask = session.dataTask(with: request) { (data, response, error) in
            guard !self.isCancelled else { return }
            
            if let error = error {
                self.complete(.failure(.requestFailed(error)))
                return
            }

            guard let data = data else {
                self.complete(.failure(.invalidData))
                return
            }
            
            print("\(Date())-DEBUG-DONE-RequestedUrl= \(request.url?.absoluteString ?? "") and" +
                " params: \(self.urlParameters) body params: \(self.bodyParameters)")
            if let httpResponse = response as? HTTPURLResponse {
                print("DEBUG statusCode = \(String(describing: httpResponse.statusCode))")
            }
            print("DEBUG DATA JSON = \(String(describing: data.prettyPrintedJSONString))")
            print("===================================================")
            
            let decoder = JSONDecoder()

            do {
                try autoreleasepool {
                    switch self.decodingStrategy {
                    case .normal:
                        try autoreleasepool {
                            let result = try decoder.decode(T.self, from: data)
                            self.complete(.success(result))
                        }
                    case .requireDataInsideContainer:
                        try autoreleasepool {
                            let result = try decoder.decode(DataContainer<T>.self, from: data)
                            self.complete(.success(result.data))
                        }
                    }
                }
            } catch let err {
                self.complete(.failure(.parsingError(err)))
            }
        }
        
        task = newTask
        task?.resume()
    }
    
    private func complete(_ result: Result<T, APIError>) {
        switch result {
        case .success:
            task = nil
            completionQueue?.async { [weak self] in
                self?.completionHandler?(result)
                self?.completionHandler = nil
                self?.state = .finished
            }
        case .failure:
            if maximumRetryCount > 0 {
                maximumRetryCount -= 1
                requestData()
            } else {
                task = nil
                completionQueue?.async { [weak self] in
                    self?.completionHandler?(result)
                    self?.completionHandler = nil
                    self?.state = .finished
                }
            }
        }
    }
    
    var completeURL: URL {
        if path.isEmpty {
            return URL(string: baseURL)!
        }
        return URL(string: baseURL)!.appendingPathComponent(path)
    }

    var request: URLRequest? {
        var request: URLRequest?
        
        switch encodingType {
        case .url:
            request = URLRequest.requestWithURLEncoding(url: completeURL, parameters: urlParameters, method: method)
        case .json:
            request = URLRequest(url: completeURL).requestWithJsonEncoding(parameters: bodyParameters)
        case .urlAndJson:
            request = URLRequest.requestWithUrlAndJsonEncoding(url: completeURL, urlParameters: urlParameters, bodyParameters: bodyParameters, method: method)
        case .formData(let attachments):
            request = URLRequest.requestWithFormData(url: completeURL, fieldParameters: bodyParameters, dataParameters: attachments)
        }
        
        headers.forEach { (key, value) in
            request?.setValue(value, forHTTPHeaderField: key)
        }
        
        request?.httpMethod = method.rawValue
        
        return request
    }
}

extension BaseOperation {
    func requestCURL() -> String {
        var components = ["$ curl -v"]

        guard let request = self.request,
              let url = request.url,
              let host = url.host
        else {
            return "$ curl command could not be created"
        }

        if let httpMethod = request.httpMethod, httpMethod != "GET" {
            components.append("-X \(httpMethod)")
        }

        if let credentialStorage = self.session.configuration.urlCredentialStorage {
            let protectionSpace = URLProtectionSpace(
                host: host,
                port: url.port ?? 0,
                protocol: url.scheme,
                realm: host,
                authenticationMethod: NSURLAuthenticationMethodHTTPBasic
            )

            if let credentials = credentialStorage.credentials(for: protectionSpace)?.values {
                for credential in credentials {
                    guard let user = credential.user, let password = credential.password else { continue }
                    components.append("-u \(user):\(password)")
                }
            }
        }

        if session.configuration.httpShouldSetCookies {
            if
                let cookieStorage = session.configuration.httpCookieStorage,
                let cookies = cookieStorage.cookies(for: url), !cookies.isEmpty
            {
                let string = cookies.reduce("") { $0 + "\($1.name)=\($1.value);" }

            #if swift(>=3.2)
                components.append("-b \"\(string[..<string.index(before: string.endIndex)])\"")
            #else
                components.append("-b \"\(string.substring(to: string.characters.index(before: string.endIndex)))\"")
            #endif
            }
        }

        var headers: [AnyHashable: Any] = [:]

        session.configuration.httpAdditionalHeaders?.filter {  $0.0 != AnyHashable("Cookie") }
                                                    .forEach { headers[$0.0] = $0.1 }

        request.allHTTPHeaderFields?.filter { $0.0 != "Cookie" }
                                    .forEach { headers[$0.0] = $0.1 }

        components += headers.map {
            let escapedValue = String(describing: $0.value).replacingOccurrences(of: "\"", with: "\\\"")

            return "-H \"\($0.key): \(escapedValue)\""
        }

        if let httpBodyData = request.httpBody, let httpBody = String(data: httpBodyData, encoding: .utf8) {
            var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")

            components.append("-d \"\(escapedBody)\"")
        }

        components.append("\"\(url.absoluteString)\"")

        return components.joined(separator: " \\\n\t")
    }
}
