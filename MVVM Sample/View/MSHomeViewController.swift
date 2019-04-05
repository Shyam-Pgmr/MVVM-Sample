//
//  MSHomeViewController.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import UIKit

class MSHomeViewController: UIViewController {

    // MARK: - Properties
    let viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

}

extension MSHomeViewController {
    
    private func setupUI() {
        
    }
    
    private func setupBindings() {
        
    }
}
