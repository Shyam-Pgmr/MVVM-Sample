//
//  APIError.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation

enum MSError: Error {
    case clientSideError
    case serverSideError
    case somethingWentWrong
    
    var message: String {
        switch self {
        case .clientSideError:
            return Constants.SomethingWentWrong
        case .serverSideError:
            return Constants.SomethingWentWrong
        case .somethingWentWrong:
            return Constants.SomethingWentWrong
        }
    }
}
