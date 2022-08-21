//
//  BaseViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit

enum TransitionType {
    case push
    case present
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutConstraint()
        configure()
        setAction()
    }
    
    func configure() {
        
    }
    
    func layoutConstraint() {
        
    }
    
    func setAction() {
        
    }
    
    func presentVC<T: UIViewController>(_ vc: T, transitionType: TransitionType, presentStyle: UIModalPresentationStyle = .automatic) {
        
        switch transitionType {
        case .push:
            self.navigationController?.pushViewController(vc, animated: true)
        case .present:
            modalPresentationStyle = presentStyle
            present(vc, animated: true)
        }
    }
    
}
