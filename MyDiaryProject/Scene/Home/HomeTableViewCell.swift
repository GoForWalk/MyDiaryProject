//
//  HomeTableViewCell.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit
import SnapKit

final class HomeTableViewCell: BaseTableViewCell {
    
    let diaryImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var diaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, contentLabel])
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        
        
        return label
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()

    override func configureCell() {
        [diaryImageView, diaryStackView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setLayoutConstraints() {
        diaryImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(8)
            make.height.equalTo(self).multipliedBy(0.85)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(diaryImageView.snp.height).multipliedBy(0.75)
        }
        
        diaryStackView.snp.makeConstraints { make in
            make.height.equalTo(diaryImageView.snp.height)
            make.leading.equalTo(diaryImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self).inset(8)
            make.centerY.equalTo(diaryImageView.snp.centerY)
        }
        
        [titleLabel, dateLabel, contentLabel].forEach {
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalTo(diaryStackView)
            }
        }
        
        [titleLabel, dateLabel].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.bottom.equalTo(diaryStackView.snp.bottom)
        }
        
    }
}

