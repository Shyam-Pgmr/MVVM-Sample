//
//  MSCollectionHeaderReusableView.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import UIKit

class MSCollectionHeaderReusableView: UICollectionReusableView {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Properties
    static let Identifier = "MSCollectionHeaderReusableView"
    
    // MARK: - Initializer
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    // MARK: - Helper
    private func configCell() {
        imageView.layer.cornerRadius = 25.0
        imageView.clipsToBounds = true
    }
    
    func setupCell(usingUser user:User) {
        imageView.kf.setImage(with: URL(string:user.image)!)
        nameLabel.text = user.name
    }
    
}
