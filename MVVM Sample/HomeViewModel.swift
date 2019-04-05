//
//  HomeViewModel.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

class HomeViewModel {

    // MARK: - Properties
    private var disposeBag = DisposeBag()
    let isLoading: ActivityIndicator =  ActivityIndicator()
    let users: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    var getUsersResult: Observable<Result<UserResponse, Error>> {
        return _getUsers.asObservable().observeOn(MainScheduler.instance)
    }
    private let _getUsers = ReplaySubject<Result<UserResponse, Error>>.create(bufferSize: 5)
    
    // MARK: - Initializer
    init() {
        
        getUsersResult.subscribe(onNext: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                self.users.accept(response.data.users)
            case .failure(let error):
                print(error)
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - API
extension HomeViewModel {
    
    func getUsers(offset: Int, count: Int) {
        
        APIs.getUsers(offset: offset, count: count)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe(onNext: { [weak self] (response) in
                self?._getUsers.onNext(Result.success(response))
                }, onError: { [weak self] (error) in
                    self?._getUsers.onNext(Result.failure(error))
            }).disposed(by: disposeBag)
    }
}
