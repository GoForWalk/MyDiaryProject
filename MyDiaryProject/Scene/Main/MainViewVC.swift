//
//  MainViewVC.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit
import SnapKit

class MainViewVC: BaseViewVC {
    
    lazy var mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageAddButton: UIButton = {
        let button = UIButton()
        
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 40), forImageIn: .normal)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        
        return button
    }()
    
    lazy var titleTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "제목을 입력하세요"
        
        return textField
    }()

    lazy var dateTextField: MainTextField = {
        let textField = MainTextField()
        textField.placeholder = "날짜를 입력하세요"
        
        return textField
    }()
    
    lazy var textView: UITextView = {
       let textView = UITextView()
        
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = true
        
        return textView
    }()
    
    let sampleButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .green
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.setTitleColor(UIColor.white, for: .normal)
        view.setTitle("저장하기", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return view
    }()
    
    override func configure() {
        [mainImageView, imageAddButton, titleTextField, dateTextField, textView, sampleButton].forEach {
            addSubview($0)
        }
    }
    
    override func layoutConstraint() {
        
        mainImageView.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(0.85)
            make.height.equalTo(self.snp.width).multipliedBy(0.70)
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
                
        imageAddButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(mainImageView).inset(8)
            make.height.equalTo(mainImageView).multipliedBy(0.2)
            make.width.equalTo(imageAddButton.snp.height)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.trailing.leading.equalTo(mainImageView)
            make.height.equalTo(44)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalTo(mainImageView)
            make.height.equalTo(44)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.trailing.leading.equalTo(mainImageView)
            make.height.equalTo(self).multipliedBy(0.2)
        }
        
        sampleButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.trailing.leading.equalTo(mainImageView)
        }

    }//: layoutConstraint
}
