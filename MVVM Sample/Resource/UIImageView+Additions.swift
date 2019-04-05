//
//  UIImageView+Additions.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import Foundation
import Kingfisher


extension UIImageView {
    
    func setImage(url urlString: String?, placeHolderImage: UIImage? = nil, ignoreCache: Bool = false , showloading: Bool = false) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = placeHolderImage
            return
        }
        self.kf.indicatorType = showloading ? .activity : .none
        self.kf.setImage(with: url, placeholder:placeHolderImage, options: ignoreCache ? [.forceRefresh] : nil)
    }
}
