//
//  RealmModel.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/22.
//

import Foundation
import RealmSwift

/// 테이블 이름
/// @persist = value 선언
class UserDiary: Object {
    
    @Persisted var diaryTitle: String // 제목(필수)
    @Persisted var diaryContent: String?
    @Persisted(indexed: true) var diaryDate: Date // indexed 색인 속도 up (남용금지)
    @Persisted var registedDate: Date
    @Persisted var favorite: Bool
    @Persisted var imageURL: String?
    
    //PK(필수): Int, String, UUID, OBjectID
    @Persisted(primaryKey: true) var uuID: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, registedDate: Date, imageURL: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.registedDate = registedDate
        self.favorite = false
        self.imageURL = imageURL
    }
    
}
