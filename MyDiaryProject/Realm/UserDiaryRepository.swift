//
//  UserDiaryRepository.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/26.
//

import Foundation

import RealmSwift

protocol UserDiaryRepositoryType {
    
    func fetch() -> Results<UserDiary>
    func fetchSortData(_ sortKey: String, ascending: Bool) -> Results<UserDiary>
    func fetchFilterData() -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func deleteItem(item: UserDiary, completionHandler: @escaping () -> ())
    
}

struct UserDiaryRepository: UserDiaryRepositoryType {
    
    // 리파지토리 생성
    let localRealm = try! Realm() // struct
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true)
    }

    func fetchSortData(_ sortKey: String, ascending: Bool) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sortKey, ascending: ascending)
    }
    
    func fetchFilterData() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기'")
    }
    
    func updateFavorite(item: UserDiary) {
        do {
            try localRealm.write {
                
                item.favorite = !item.favorite
                print("Realm Update Done")
            }
        } catch {
            
        }
        
    }
    
    func deleteItem(item: UserDiary, completionHandler: @escaping () -> ()) {
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
            completionHandler()
        } catch let error as NSError{
            print(error)
        }

    }
}
