//
//  User.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let image: String
    let items: [String]
}

extension User: Codable {}

extension User: CustomStringConvertible {
    var description: String {
        return name
    }
}
