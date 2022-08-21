//
//  BaseViewVC.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit

class BaseViewVC: UIView {
    
    var subviewList: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .black
    }
    
    func layoutConstraint() {
        
    }
    
    
    
}
