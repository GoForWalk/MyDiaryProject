//
//  TabBarController.swift
//  MyDiaryProject
//
//  Created by sae hun chung on 2022/08/19.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func setupTabBarLayout() {
        // tabbar 아이템의 틴트 컬러 변경
        tabBar.tintColor = .white
        
        tabBar.barTintColor = .black
        
    }
    
    private func setupTabbarItem() {
        // Tabbar의 아이템 설정
        
        // photo Tab
        let mainViewController = MainViewController()
        mainViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "square.and.pencil.circle"),
            selectedImage: UIImage(systemName: "square.and.pencil.circle.fill")
        )
        
        viewControllers = [
            mainViewController
        ]
    }
}
