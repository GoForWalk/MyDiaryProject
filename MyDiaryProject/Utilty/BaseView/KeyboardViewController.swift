//
//  KeyboardViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/20.
//

import UIKit

class KeyboardViewController: BaseViewController {
    
    var restoreFrameValue: CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotifications(vc: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications(vc: self)
    }
    
    /// 키보드 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications<T: UIViewController>(vc: T) {
        print(#function, self.description)
        NotificationCenter.default.addObserver(vc, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(vc, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 키보드 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications<T: UIViewController>(vc: T) {
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(vc, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print(#function, self.description)
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y -= (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!/2)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        print(#function, self.description)
        
        if self.view.frame.origin.y != restoreFrameValue {
            if let keyboardFrame: NSValue =
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                UIView.animate(withDuration: 0.5) {
                    self.view.frame.origin.y += (keyboardHeight
                    + (self.tabBarController?.tabBar.frame.size.height)!/2)

                }
            }
        }
    }
}
