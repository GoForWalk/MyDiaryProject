//
//  MainViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit
import Alamofire

final class MainViewController: KeyboardViewController {

    let mainView = MainViewVC()
    

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func configure() {
        mainView.textView.delegate = self
        mainView.titleTextField.delegate = self
        mainView.nameTextField.delegate = self
    }
    
    override func setAction() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(resignKeyboard(_:)))
        mainView.addGestureRecognizer(tap)
        
        mainView.nameTextField.addTarget(self, action: #selector(resignKeyboard(_:)), for: .editingDidEndOnExit)
        
        mainView.titleTextField.addTarget(self, action: #selector(resignKeyboard(_:)), for: .editingDidEndOnExit)
        
    }

}

// MARK: Selector Function
extension MainViewController {
    
    @objc func resignKeyboard(_ sender: Any?) {
        
        if let textView = sender as? UITextView {
            textView.resignFirstResponder()
            return
        }
        
        if let textField = sender as? UITextField {
            textField.resignFirstResponder()
            return
        }
        
    }

}

extension MainViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.view.frame.origin.y = restoreFrameValue
        return true
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.frame.origin.y = self.restoreFrameValue
    }
    
}

extension MainViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.frame.origin.y = restoreFrameValue
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.frame.origin.y = self.restoreFrameValue
        return true
    }
}
