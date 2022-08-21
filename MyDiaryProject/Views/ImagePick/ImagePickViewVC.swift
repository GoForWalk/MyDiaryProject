//
//  ImagePickViewVC.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/20.
//

import UIKit
import SnapKit

class ImagePickViewVC: BaseViewVC {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .lightGray
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 4
        let numOfCell: CGFloat = 3
        let numOfSpace: CGFloat = numOfCell + 1
        
        let width = (UIScreen.main.bounds.width - (spacing * numOfSpace)) / numOfCell
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width * 1.15)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        backgroundColor = .lightGray
        
        [searchBar, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.trailing.leading.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
