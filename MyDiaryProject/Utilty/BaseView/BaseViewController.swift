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
    case presentNavigation
}

class BaseViewController: UIViewController {

    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutConstraint()
        configure()
        setAction()
    }
    
    func configure() {
        formatter.dateFormat = setDateFormatter()
    }
    
    func layoutConstraint() {
        
    }
    
    func setAction() {
        
    }
    
    func setDateFormatter() -> String {
        return "yyyy.MM.dd hh.mm.ss"
    }
    
    func presentVC<T: UIViewController>(_ vc: T, transitionType: TransitionType, presentStyle: UIModalPresentationStyle = .automatic) {
        
        switch transitionType {
        case .push:
            self.navigationController?.pushViewController(vc, animated: true)
        case .present:
            modalPresentationStyle = presentStyle
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
}
