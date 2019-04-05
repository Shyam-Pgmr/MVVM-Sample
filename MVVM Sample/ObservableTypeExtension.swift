//
//  ObservableTypeExtension.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    
    func mapObject<Model: Codable>(type: Model.Type, response:Observable<(HTTPURLResponse, Data)>) -> Observable<Model> {
        return response.flatMap({ (response, data) -> Observable<Model> in
            do {
                switch response.statusCode {
                case StatusCode.SuccessRange:
                    do {
                        let object =  try JSONDecoder().decode(Model.self, from: data)
                        return Observable.just(object)
                    } catch (let error) {
                        throw error
                    }
                case StatusCode.ClientSideError:
                    throw MSError.clientSideError
                case StatusCode.ServerSideError:
                    throw MSError.serverSideError
                default:
                    throw MSError.serverSideError
                }
            }
            catch (let error) {
                throw error
            }
        })
    }
}
