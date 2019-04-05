//
//  APIManager.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

struct APIManager {
    
    // Shared instance
    static let shared = APIManager()
    
    let sessionManager: SessionManager

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func requestObserable(api: EndPoint) -> Observable<(HTTPURLResponse, Data)> {
        return sessionManager.rx.request(urlRequest: api).responseData()
    }
}
