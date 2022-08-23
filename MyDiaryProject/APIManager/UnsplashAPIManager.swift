//
//  UnsplashAPIManager.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class UnsplashAPIManger {
    
    static let share = UnsplashAPIManger()
    
    private init () {}
    
    func fetchImages(page: Int, completionHandler: @escaping ([UnSplashDataProtocol]) -> ()) {
        
        let url = UnSplashEndPoint.photoURL
        
        let param: Parameters = UnplshParam.getParam(paramType: .photo, page: page, searchWord: nil)
        
        AF.request(url, method: .get, parameters: param).validate().responseData { data in
            
            switch data.result {
            case .success(let result):
                let json = JSON(result)
                print(json)
                
                var resultList: [UnSplashDataProtocol] = []
                
                resultList = json.arrayValue.map { json -> UnsplashData in
                    
                    let smallImageURL = json["urls"]["small"].stringValue
                    let mediumImageURL = json["urls"]["regular"].stringValue
                    
                    return UnsplashData(smallImageURL: smallImageURL, mediumImageURL: mediumImageURL)
                }
                
                completionHandler(resultList)
                print(#function, "fetchDataDone")
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    
}
