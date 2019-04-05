//
//  UserResponse.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation

struct UserResponse {
    let data: Data
    
    struct Data: Codable {
        let users: [User]
    }
}

extension UserResponse: Codable {}
