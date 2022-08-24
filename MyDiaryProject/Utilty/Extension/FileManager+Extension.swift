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
        
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 파일 경로, 이미지를 저장할 위치
        
        // 저장할 이미지 압축과정
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
            
        } catch let error {
            print("file save error", error)
        }
    }

    func loadImageFromDocument(fileName: String) -> UIImage {

        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")!} // singleton Pattern, Document 경로를 가져온다.
        
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 파일 경로, 이미지를 저장할 위치

        guard let image = UIImage(contentsOfFile: fileURL.path) else { return UIImage(systemName: "star.fill")!}
                
        return image
    }

    func removeImageFromDocuement(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // singleton Pattern, Document 경로를 가져온다.

        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 파일 경로, 이미지를 저장할 위치
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error as NSError {
            print(error)
        }
    }

}
