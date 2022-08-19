//
//  MainTextField.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit

class MainTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .lightGray
        textColor = .white
        textAlignment = .center
        
    }
    
}
