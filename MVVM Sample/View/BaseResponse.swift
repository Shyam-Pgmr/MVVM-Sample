//
//  BaseResponseModel.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation

struct BaseResponse {
    let status: Bool
    let message: String?
}

extension BaseResponse: Codable {}
