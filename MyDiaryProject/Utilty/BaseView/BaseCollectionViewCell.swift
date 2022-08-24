//
//  BaseCollectionCell.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/21.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setLayoutConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell() {
        
    }
    
    func setLayoutConstraints() {
        
    }
    
}
