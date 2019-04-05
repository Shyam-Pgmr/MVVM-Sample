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
    
    private static func handleResponse<Model: Codable>(response: Observable<(HTTPURLResponse, Data)>, type: Model.Type, callback: @escaping (Result<Model, Error>) -> Void) -> Disposable {
        return response.mapObject(type: type, response: response).observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                callback( Result.success(data) )
            }, onError: { (error) in
                callback( Result.failure(error) )
            })
    }
}

extension APIs {
    
    static func getUsers(offset: Int, count: Int, completion:@escaping (Result<UserResponse, Error>)->Void) -> Disposable {
        return handleResponse(response: APIManager.shared.requestObserable(api: .users(offset: offset, count: count)), type: UserResponse.self, callback: completion)
    }
}
