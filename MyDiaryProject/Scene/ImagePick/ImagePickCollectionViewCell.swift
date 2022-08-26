//
//  ImagePickCollectionViewCell.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/21.
//

import UIKit
import SnapKit

final class ImagePickCollectionViewCell: BaseCollectionViewCell {
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    override func configureCell() {
        self.addSubview(imageView)
    }
    
    override func setLayoutConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self)
        }
    }
}
