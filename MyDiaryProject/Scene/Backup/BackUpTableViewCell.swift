//
//  BackUpTableViewCell.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit

class BackUpTableViewCell: BaseTableViewCell {
    
    let backuptitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    let backupDateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()

    let backupImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "doc.badge.gearshape.fill")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let capacityLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func configureCell() {
        [backuptitleLabel, backupDateLabel, backupImageView, capacityLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setLayoutConstraints() {
        backupImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(12)
            make.width.height.equalTo(self.snp.height).multipliedBy(0.6)
        }
        
        capacityLabel.snp.makeConstraints { make in
            make.top.equalTo(backupImageView.snp.bottom).offset(4)
            make.leading.equalTo(backupImageView.snp.leading)
            make.height.equalTo(12)
        }
        
        backuptitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(12)
            make.leading.equalTo(backupImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
            
        }
        
        backupDateLabel.snp.makeConstraints { make in
            make.top.equalTo(backuptitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(backupImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(12)
        }
    }
    
}
