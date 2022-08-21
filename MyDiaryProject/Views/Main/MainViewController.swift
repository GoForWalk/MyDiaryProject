//
//  MainViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit
import Alamofire
import Kingfisher

final class MainViewController: KeyboardViewController {

    let mainView = MainViewVC()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        addNotificationObserver()
    }
    

    deinit {
        removeNotificationObserver()
    }
    
    override func configure() {
        mainView.textView.delegate = self
        mainView.titleTextField.delegate = self
       
        mainView.nameTextField.delegate = self
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(getPhoto(_:)), name: Notification.Name.imagePick, object: nil)
    }
    
    func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.imagePick, object: nil)
    }
        
    
    override func setAction() {
        print(#function)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingKeyboard))

        mainView.addGestureRecognizer(tap)
        mainView.mainImageView.addGestureRecognizer(tap)
        
        mainView.nameTextField.addTarget(self, action: #selector(resignKeyboard(_:)), for: .editingDidEndOnExit)
        
        mainView.titleTextField.addTarget(self, action: #selector(resignKeyboard(_:)), for: .editingDidEndOnExit)
        
        mainView.imageAddButton.addTarget(self, action: #selector(pushImagePickView(_:)), for: .touchUpInside)
        
    }

}

// MARK: Selector Function
extension MainViewController {
    
    @objc func endEditingKeyboard(_ sender: UITapGestureRecognizer?) {
        print(#function)
        mainView.endEditing(true)
    }
    
    
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

    @objc func pushImagePickView(_ sender: UIButton?) {
        presentVC(ImagePickViewController(), transitionType: .push)
    }
    
    @objc func getPhoto(_ notification: NSNotification) {
        print(#function)
        guard let strURL = notification.userInfo?["imageURL"] as? String else { return }
        
        let url = URL(string: strURL)!
        
        mainView.mainImageView.kf.setImage(with: url)
    }
}

extension MainViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

    }
    
}

extension MainViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        return true
    }
}
