//
//  API.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation
import Alamofire

enum EndPoint {
    
    // API Endpoints
    case users(offset: Int, count: Int)
    
}

extension EndPoint: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        
        // HTTP Method
        var method: HTTPMethod {
            switch self {
            case .users:
                return .get
            }
        }
        
        // Request header
        var headers: [String: String] {
            return [:]
        }
        
        // Paramters
        var params: [String: Any]? {
            switch self {
            case .users(let offset, let count):
                return [ParamKey.offset: offset, ParamKey.count: count]
            }
        }
        
        // API url
        var url: URL {
            let apiVersion = "api/"
            var relativePath: String {
                switch self {
                case .users:
                    return "users?"
                }
            }
            var completeUrl: String {
                return baseURL + apiVersion + relativePath
            }
            guard let url = URL(string: completeUrl) else { fatalError("Invalid API URL")}
            return url
        }
        
        // URL Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        return try URLEncoding.default.encode(urlRequest, with: params)
    }
}
