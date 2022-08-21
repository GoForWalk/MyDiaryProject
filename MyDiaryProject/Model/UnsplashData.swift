//
//  UnsplashData.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/21.
//

import Foundation

protocol UnSplashDataProtocol {
    
    var smallImageURL: String { get set }
    var mediumImageURL: String { get set }
    
}

struct UnsplashData: UnSplashDataProtocol {
    
    var smallImageURL: String
    var mediumImageURL: String
    
}
