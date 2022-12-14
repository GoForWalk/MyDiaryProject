//
//  MainViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit
import Alamofire
import Kingfisher
import RealmSwift
import PhotosUI

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}


final class MainViewController: KeyboardViewController {

    let mainView = MainViewVC()

    let repository: UserDiaryRepositoryType = UserDiaryRepository()
    
    var datepicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
        
    var currentDate = Date()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", repository.getRealmURL())
        
//        addNotificationObserver()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
//        removeNotificationObserver()
    }
    
    override func configure() {
        super.configure()
        mainView.textView.delegate = self
        mainView.titleTextField.delegate = self
       
        mainView.dateTextField.delegate = self
        mainView.dateTextField.inputView = datepicker
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingKeyboard(_:)))
        
        view.addGestureRecognizer(tap)
        
        mainView.dateTextField.text = formatter.string(from: currentDate)
    }
    
//    private func addNotificationObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(getPhoto(_:)), name: Notification.Name.imagePick, object: nil)
//    }
//
//    private func removeNotificationObserver() {
//        NotificationCenter.default.removeObserver(self, name: Notification.Name.imagePick, object: nil)
//    }
        
    override func setDateFormatter() -> String {
        print(#function)
        return "yyyy.MM.dd"
    }
    
    override func setAction() {
        print(#function)
                
        mainView.titleTextField.addTarget(self, action: #selector(resignKeyboard(_:)), for: .editingDidEndOnExit)
        
        mainView.imageAddButton.addTarget(self, action: #selector(presentAlertSheet(_:)), for: .touchUpInside)
        
        mainView.sampleButton.addTarget(self, action: #selector(saveData(_:)), for: .touchUpInside)
        
        datepicker.addTarget(self, action: #selector(setDate(_:)), for: .valueChanged)
    }

}

// MARK: Selector Function
extension MainViewController {
    
    // Realm Create Sample
    @objc private func saveData(_ sender: UIButton) {
        self.mainView.endEditing(true)

        guard let title = mainView.titleTextField.text, !title.isEmpty else { return }
        
        let date = currentDate
        
        let task = UserDiary(diaryTitle: title , diaryContent: mainView.textView.text, diaryDate: date, registedDate: Date(), imageURL: nil)
        
        repository.addItem(item: task)
        
        if let image = mainView.mainImageView.image {
            saveImageToDocument(fileName: "\(task.uuID)", image: image)
        }
        
        mainView.titleTextField.text = ""
        mainView.mainImageView.image = nil
        mainView.textView.text = ""
    }
    
    
    @objc private func endEditingKeyboard(_ sender: UITapGestureRecognizer) {
        print(#function)
        mainView.endEditing(true)
    }
    
    
    @objc private func resignKeyboard(_ sender: Any?) {
        
        if let textView = sender as? UITextView {
            textView.resignFirstResponder()
            return
        }
        
        if let textField = sender as? UITextField {
            textField.resignFirstResponder()
            return
        }
        
    }

//    @objc private func dateTextFieldTapped(_ sender: UITextField) {
//        removeNotificationObserver()
//    }
//
//    @objc private func dateTextFieldEndEdited(_ sender: UITextField) {
//        addNotificationObserver()
//    }
    
    @objc private func getPhoto(_ notification: NSNotification) {
        print(#function)
        guard let strURL = notification.userInfo?["imageURL"] as? String else { return }
        
        let url = URL(string: strURL)!
        
        mainView.mainImageView.kf.setImage(with: url)
    }
    
    @objc func setDate(_ datePicker: UIDatePicker) {
        mainView.dateTextField.text = formatter.string(from: datePicker.date)
        currentDate = datePicker.date
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
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        return true
    }
}

// MARK: ?????? ?????? ?????? ??????
extension MainViewController {
    
    @objc private func presentAlertSheet(_ sender: UIButton) {
        
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let unsplash = UIAlertAction(title: "UnSplash", style: .default) { [weak self] _ in
            self?.pushImagePickView()
        }
        
        let phpPicker = UIAlertAction(title: "Photo Library", style: .default) {[weak self] _ in
            self?.pushPHPickerView()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        
        alertSheet.addAction(unsplash)
        alertSheet.addAction(phpPicker)
        alertSheet.addAction(cancel)
        
        present(alertSheet, animated: true)
    }

    private func pushImagePickView() {
        let vc = ImagePickViewController()
        vc.delegate = self // Delegate ??????
        
        presentVC(vc, transitionType: .push)
        view.endEditing(true)
    }
    
    private func pushPHPickerView() {
        present(setPHPickerViewController(), animated: true)
        view.endEditing(true)
    }
}

// MARK: PHPickerViewController
extension MainViewController: PHPickerViewControllerDelegate {
    
    private func setPHPickerViewController() -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        return picker
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)

        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.mainView.mainImageView.image = image as? UIImage
                }
            }
        } else {
            print("PHPickerViewController Error")
        }
        
    }
}

// MARK: SelectImageDelegate
extension MainViewController: SelectImageDelegate {
    
    func sendImageData(image: UIImage) {
        mainView.mainImageView.image = image
        print(#function)
    }
}

// TODO: Error ????????? ????????? ?????? ?????? ?????????
enum MyDiaryError: Error {
    case titleEmpty
    case dateEmpty
    
}


