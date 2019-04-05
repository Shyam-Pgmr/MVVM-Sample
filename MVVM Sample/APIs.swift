//
//  API.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation
import RxSwift

struct APIs {
    
    init() { }
}

// Helper
extension APIs {
    
    private static func handleResponse<Model: Codable>(response: Observable<(HTTPURLResponse, Data)>, type: Model.Type) -> Observable<Model> {
        return response.mapObject(type: type, response: response)
    }
}

extension APIs {
    
    static func getUsers(offset: Int, count: Int) -> Observable<UserResponse> {
        return handleResponse(response: APIManager.shared.requestObserable(api: .users(offset: offset, count: count)), type: UserResponse.self)
    }
}
