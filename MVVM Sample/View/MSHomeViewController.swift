//
//  MSHomeViewController.swift
//  MVVM Sample
//
//  Created by Shyam Kumar on 05/04/19.
//  Copyright © 2019 Shyam Kumar. All rights reserved.
//

import UIKit
import RxSwift

class MSHomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    private var offset = 0
    private let count = 100
    private var users: [User] {
        return viewModel.users.value
    }
    
    
    // MARK: - Constants
    private let MinimumAndLineSpacing: CGFloat = 12.0
    private let SectionInset: CGFloat = 12.0
    private let SectionInsetTop: CGFloat = 2.0
    private let SectionHeaderHeight: CGFloat = 64.0
    private let SectionFooterHeight: CGFloat = 44.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        actionsAfterSubscription()
    }

}

extension MSHomeViewController {
    
    private func setupUI() {
        // Register Cells
        collectionView.register (UINib(nibName: String(describing:MSCollectionHeaderReusableView.self), bundle: nil) , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MSCollectionHeaderReusableView.Identifier)
    }
    
    private func setupBindings() {
        
        viewModel.users
        .asObservable()
            .map{ _ in }
            .subscribe(onNext: { [weak self] in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.isLoading
        .distinctUntilChanged()
        .asDriver(onErrorJustReturn: false)
        .drive(activityIndicatorView.rx.isAnimating)
        .disposed(by: disposeBag)
    }
    
    private func actionsAfterSubscription() {
        viewModel.getUsers(offset: offset, count: count)
    }
}

// MARK: - UICollectionView DataSource
extension MSHomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MSImageCollectionViewCell.Identifier, for: indexPath) as! MSImageCollectionViewCell
        let imageUrl = users[indexPath.section].items[indexPath.row]
        cell.image = imageUrl
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MSCollectionHeaderReusableView.Identifier, for: indexPath) as! MSCollectionHeaderReusableView
            headerView.setupCell(usingUser: users[indexPath.section])
            return headerView
        }
        return UICollectionReusableView()
    }
    
}

// MARK: - UICollectionView Delegate FlowLayout
extension MSHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return MinimumAndLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return MinimumAndLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGFloat = 0.0
        let isFullWidthForFirstRow = (users[indexPath.section].items.count % 2 != 0 && indexPath.row == 0)
        if isFullWidthForFirstRow {
            // Give full width of collectionView for 1st row of 'Section with Even number of items'
            size = collectionView.frame.width - (SectionInset * 2)
        } else {
            // Else show 2 items in a row
            size = ((collectionView.frame.width - MinimumAndLineSpacing - (SectionInset * 2)) / 2)
        }
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: SectionHeaderHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: SectionInsetTop, left: SectionInset, bottom: SectionInset, right: SectionInset)
    }
}
