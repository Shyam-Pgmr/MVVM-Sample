//
//  APIConstants.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation

let baseURL = "http://sd2-hiring.herokuapp.com/"

struct ParamKey {
    static let offset = "offset"
    static let count = "count"
}

/// Status Codes of response
struct StatusCode {
    static let InvalidAccessToken = 401
    static let SuccessRange = 200..<300
    static let ClientSideError = 400..<500
    static let ServerSideError = 500..<600
}
