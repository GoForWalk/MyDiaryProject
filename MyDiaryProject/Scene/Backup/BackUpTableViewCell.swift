//
//  BackUpTableViewCell.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit
import SwiftUI

final class BackUpTableViewCell: BaseTableViewCell {
    
    let backuptitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.text = "backup title"
        return label
    }()
    
    let backupCapacityLabel: UILabel = {
        let label = UILabel()
        label.text = "backup Capacity"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()

    let backupUploadButton: UIButton = {
        
        let imageView = UIButton()
        let buttonConfigure = UIImage.SymbolConfiguration(pointSize: 40)
//        imageView.layer.borderWidth = 1.0
//        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.tintColor = .lightGray
        imageView.setImage(UIImage(systemName: "arrow.up.doc"), for: .normal)
        imageView.backgroundColor = .clear
        imageView.setPreferredSymbolConfiguration(buttonConfigure, forImageIn: .normal)
        
        return imageView
    }()
        
    override func configureCell() {
        [backuptitleLabel, backupCapacityLabel, backupUploadButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setLayoutConstraints() {
        backupUploadButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(12)
            make.width.equalTo(backupUploadButton.snp.height)
            make.top.bottom.equalTo(self).inset(20)
        }
        
        backuptitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backupUploadButton.snp.top)
            make.leading.equalTo(backupUploadButton.snp.trailing).offset(28)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
            
        }
        
        backupCapacityLabel.snp.makeConstraints { make in
            make.top.equalTo(backuptitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(backupUploadButton.snp.trailing).offset(28)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
    }
    
}
