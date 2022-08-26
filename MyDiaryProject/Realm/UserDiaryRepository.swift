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
    func fetchFilterByDate(date: Date) -> Results<UserDiary>
    func addItem(item: UserDiary)
    func getRealmURL() -> String
    func fetchFavoriteItems() -> Results<UserDiary>
}

struct UserDiaryRepository: UserDiaryRepositoryType {
    
    // 리파지토리 생성
    private let localRealm = try! Realm() // struct
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: true)
    }

    func fetchSortData(_ sortKey: String, ascending: Bool) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: sortKey, ascending: ascending)
    }
    
    func fetchFilterData() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기'")
        // [c] : 대소문자 상관없이 색인
//            .filter("diaryTitle = '오늘의 일기'") // 해당 스트링 값으로 색인하는 방법 (정확하게 맞는 값만 출력한다.)
    }
    
    func fetchFavoriteItems() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).where {
            $0.favorite == true
        }
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
    
    func fetchFilterByDate(date: Date) -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryDate >= %@ AND diaryDate < %@", date , Date(timeInterval: 86400, since: date)) // NSPredicate
//        filter { $0.diaryDate }
    }
    
    func addItem(item: UserDiary) {
        
        do {
            try localRealm.write{
                print(item)
                localRealm.add(item) // Create
                print("Realm add Done")
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func getRealmURL() -> String {
        return "\(localRealm.configuration.fileURL!)"
    }
}
