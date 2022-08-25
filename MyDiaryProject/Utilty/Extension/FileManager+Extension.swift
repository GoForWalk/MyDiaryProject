//
//  FileManager+Extension.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // singleton Pattern, Document 경로를 가져온다.
        print("documentDirectory: ", documentDirectory)
        
        let photoFileURL = documentDirectory.appendingPathComponent("photo").appendingPathComponent(fileName) // 세부 파일 경로, 이미지를 저장할 위치
        
        // 저장할 이미지 압축과정
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: photoFileURL)
            
        } catch let error {
            print("file save error", error)
        }
    }

    func loadImageFromDocument(fileName: String) -> UIImage {

        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")!} // singleton Pattern, Document 경로를 가져온다.
        
        let photoFileURL = documentDirectory.appendingPathComponent("photo").appendingPathComponent(fileName) // 세부 파일 경로, 이미지를 저장할 위치

        guard let image = UIImage(contentsOfFile: photoFileURL.path) else { return UIImage(systemName: "star.fill")!}
                
        return image
    }

    func removeImageFromDocuement(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // singleton Pattern, Document 경로를 가져온다.

        let photoFileURL = documentDirectory.appendingPathComponent("photo").appendingPathComponent(fileName) // 세부 파일 경로, 이미지를 저장할 위치

        do {
            try FileManager.default.removeItem(at: photoFileURL)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // singleton Pattern, Document 경로를 가져온다.
        
        return documentDirectory
    }

    func fetchDocumentZipFile() -> [String]? {
        
        do {
            guard let path = documentDirectoryPath() else { return nil}

            // 파일안의 모든 파일들 검색
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: [.fileSizeKey])
            
            print("docs: \(docs)")
            
            let zip = docs.filter {
                return $0.pathExtension == "zip"
            }
            print("zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("result: \(result)")
            
            return result
            
            
        } catch {
            print("Error")
        }
        
        return nil
    }
    
    /// photo file 이 있는지, 확인하고 없으면, photo 파일 생성
    func photoFolderManager() {
        
        guard let document = documentDirectoryPath() else { return }
        
        let photoFileURL = document.appendingPathComponent("photo")
        
        // photo file 이 없는 경우
        if !FileManager.default.fileExists(atPath: photoFileURL.path) {
            do {
                try FileManager.default.createDirectory(at: photoFileURL, withIntermediateDirectories: false, attributes: nil)
                print("photo File 셍성 완료")
            } catch {
                print("photo file 생성 실패")
            }
        } else {
            print("photo file 존재")
        }
        
    }
    
    func deleteBackupData(fileName: String, completionHandler: @escaping () -> ()) {
        
        guard let document = documentDirectoryPath() else { return }
        
        let backupFileURL = document.appendingPathComponent(fileName)
        
        do {
           try FileManager.default.removeItem(at: backupFileURL)
            completionHandler()
        } catch let error as NSError {
            print("backupFile delete Error: \(error)")
        }
        
    }
    
}
