//
//  BackUpViewController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit
import Zip
import RealmSwift
import JGProgressHUD

class BackUpViewController: BaseViewController {
    
    let backupView = BackUpViewVC()
    
    var currentBackupFileName = ""
    var currentRestoreFileName = ""
    var backupFiles: [String]? {
        didSet {
            backupView.tableView.reloadData()
        }
    }
    let hud = JGProgressHUD()
    
    override func loadView() {
        self.view = backupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backupFiles = fetchDocumentZipFile()
    }
    
    override func configure() {
        super.configure()
        backupView.tableView.delegate = self
        backupView.tableView.dataSource = self
        backupView.tableView.register(BackUpTableViewCell.self, forCellReuseIdentifier: BackUpTableViewCell.identifier)
    }
    
    override func setAction() {
        backupView.backUpButton.addTarget(self, action: #selector(backupButtonTapped(_:)), for: .touchUpInside)
        
        backupView.restorebutton.addTarget(self, action: #selector(restoreButtonTapped(_:)), for: .touchUpInside)
    }
 
    override func setDateFormatter() -> String {
        return "yyyy.MM.dd_hh:mm:ss"
    }
}

extension BackUpViewController {
    
    // MARK: Backup
    @objc func backupButtonTapped(_ sender: UIButton) {
        
        var urlPaths = [URL]()
        
        // 도큐먼트에 백업 파일 확인
        // ~~~~~~/Documents
        guard let path = documentDirectoryPath() else { // 파일 위치 주소 가져오기
            // TODO: Show Alert ("도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm") // doc 파일의 realm 파일 주소
        let photoFile = path.appendingPathComponent("photo") // photo 파일의 주소
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            // realm 파일이 해당 경로에 존재하는지 확인
            // TODO: Show Alert ("백업할 파일이 없습니다.")
            return
        }
        print(#function, realmFile)
        urlPaths.append(URL(string: realmFile.path)!) // 해당경로에 파일이 존재하는것을 확인하면, URL을 배열에 append
        
        // 백업 파일을 압축: URL
        // import zip
        do {
            currentBackupFileName = "SeSAC_Diray_\(formatter.string(from: Date()))"
            
            let zipFilePath = try Zip.quickZipFiles([realmFile, photoFile], fileName: currentBackupFileName, progress: { progress in
                print("zip Progress: \(progress)")
                
                if progress == 1.0 {
                    self.backupFiles = self.fetchDocumentZipFile()
                }
            })
            
            print("Achive Location: \(zipFilePath)")
            
            // ActivityViewController
            showActivityViewController(fileName: "\(self.currentBackupFileName).zip")
        } catch {
            // TODO: Show Alert ("압축이 실패했습니다.")
            print("압축이 실패했습니다.")
        }
        
    }
    // MARK: DocumentPickerView Present
    @objc func restoreButtonTapped(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
    @objc func uploadbuttonTapped(_ sender: UIButton) {
        print(#function)
        guard let fileName = backupFiles?[sender.tag] else { return }
        
        showActivityViewController(fileName: fileName)
    }
    
    func showActivityViewController(fileName: String) {
        
        guard let path = documentDirectoryPath() else { // 파일 위치 주소 가져오기
            // TODO: Show Alert ("도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let backupFileURL = path.appendingPathComponent(fileName) // zip 파일의 파일 주소
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
}

// MARK: UIDocumentPickerDelegate
extension BackUpViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        // 압축파일을 풀어서 복구시키기
        
        guard let selectFileURL = urls.first else {
            // TODO: show alert
            print("선택한 파일에 오류가 있습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else { // 파일 위치 주소 가져오기
            // TODO: Show Alert ("도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectFileURL.lastPathComponent)
        print("sandboxFileURL: \(sandboxFileURL)")
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
//            let fileURL = path.appendingPathComponent(currentRestoreFileName)
            let fileURL = sandboxFileURL
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    print("복구 완료")
                })
                
            } catch {
                print("압축 해제 실패")
            }
            
        } else {
            
            do {
                // 파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectFileURL, to: sandboxFileURL)
                
//                let fileURL = path.appendingPathComponent(currentRestoreFileName)
                let fileURL = sandboxFileURL
                
                self.hud.show(in: self.view)
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    
                    self.hud.textLabel.text = "\(Int(progress * 100))%"
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    
                    self.hud.dismiss(animated: true)
                    print("unzippedFile: \(unzippedFile)")
                    print("복구 완료")
                    self.resetViewController()
                })
                
            } catch {
                print("압축 해제 실패")
            }
            
        }
        
    }
    
    func resetViewController() {
        // iOS13+ SceneDelegate를 쓸 때 동작하는 코드
        // 앱을 처음 실행하는 것 처럼 동작하게 한다.
        // SceneDelegate 밖에서 window에 접근하는 방법
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // 생명주기 담당
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = TabbarController()
        
        // window에 접근
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension BackUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let backupFiles = backupFiles else { return 0 }
        return backupFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackUpTableViewCell.identifier) as? BackUpTableViewCell, let backupFiles = backupFiles else { return UITableViewCell()}
        
        cell.tag = indexPath.row
        cell.backupUploadButton.tag = indexPath.row
        cell.backuptitleLabel.text = backupFiles[indexPath.row]
        cell.backupUploadButton.addTarget(self, action: #selector(uploadbuttonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "delete") { action, view, handler in
            
            guard let fileName = self.backupFiles?[indexPath.row] else { return }
            
            self.deleteBackupData(fileName: fileName) { [ weak self] in
                self?.backupFiles = self?.fetchDocumentZipFile()
            }
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}
