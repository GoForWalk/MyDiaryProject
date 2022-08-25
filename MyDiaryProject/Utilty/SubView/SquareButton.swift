//
//  SquareButton.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit
import SnapKit

class SquareButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
        setLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
        layer.cornerRadius = UIConstant.cornerRadius
        clipsToBounds = true
        tintColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        setTitleColor(.white, for: .normal)
    }
    
    func setLayoutConstraint() {

    }
}
