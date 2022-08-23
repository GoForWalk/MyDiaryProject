//
//  Endpoint.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/21.
//

import Foundation

enum UnSplashEndPoint {
    
    static let rootURL = "https://api.unsplash.com/"
    
    static var photoURL: String {
        return rootURL + "/photos"
    }
    
    static var searchURL: String {
        return rootURL + "/search/photos"
    }
    
    static var randomURL: String {
        return rootURL + "/photos/random"
    }
}

enum UnplashParamType {
    case photo, search, random
}

struct UnplshParam {
    
    static func getParam(paramType: UnplashParamType, page: Int = 1, searchWord: String?) -> Dictionary<String, String> {
        
        switch paramType {
        case .photo:
            return ["client_id" : APIKey.UNSPLASH_ACCESS_KEY.rawValue,
                    "page" : "\(page)",
                    "per_page" : "20"
            ]
        case .search:
            return ["client_id" : APIKey.UNSPLASH_ACCESS_KEY.rawValue ,"count" : "20"]
        case .random:
            return ["client_id" : APIKey.UNSPLASH_ACCESS_KEY.rawValue ,"count" : "20"]
        }
    }
    
}
