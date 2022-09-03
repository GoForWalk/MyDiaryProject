//
//  TabBarController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit
import RealmSwift

final class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbarItem()
        setupTabBarLayout()
        photoFolderManager()
        
        do {
           let _ = try Realm()
        } catch let error as NSError{
            print(error)
        }
    }
    
    private func setupTabBarLayout() {
        // tabbar 아이템의 틴트 컬러 변경
        tabBar.tintColor = .white
        
        tabBar.barTintColor = .lightGray
        
    }
    
    private func setupTabbarItem() {
        // Tabbar의 아이템 설정
        
        // photo Tab
        let mainViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(
            title: "Main",
            image: UIImage(systemName: "pencil.circle"),
            selectedImage: UIImage(systemName: "pencil.circle.fill")
        )
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        let backupViewContrller = BackUpViewController()
        backupViewContrller.tabBarItem = UITabBarItem(
            title: "BackUp",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        
        viewControllers = [
            UINavigationController(rootViewController: mainViewController),
            UINavigationController(rootViewController: homeViewController),
            UINavigationController(rootViewController: backupViewContrller)
            
        ]
    }
}
