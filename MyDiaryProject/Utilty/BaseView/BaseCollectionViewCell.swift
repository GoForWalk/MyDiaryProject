//
//  BaseCollectionCell.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/21.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
//    override func awakeFromNib() {
//        print(self, #function)
//        configureCell()
//        setLayoutConstraints()
//    }
//
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setLayoutConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell() {
        
    }
    
    func setLayoutConstraints() {
        
    }
    
}
