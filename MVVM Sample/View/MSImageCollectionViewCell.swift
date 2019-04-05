//
//  MSImageCollectionViewCell.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import UIKit

class MSImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var userImageView: UIImageView!
    
    // MARK: - Properties
    static let Identifier = "MSImageCollectionViewCell"
    var image: String! {
        didSet {
            userImageView.setImage(url: image)
        }
    }
}
