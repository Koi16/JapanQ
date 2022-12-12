//
//  TabBarController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/12.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タブアイコンの色
        //self.tabBar.unselectedItemTintColor = UIColor(hex: "f5f6f7")
        self.tabBar.tintColor = UIColor(hex: "3b69ad")
        
        
        //タブバーの背景色の決定
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(hex: "74a5ed")
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        //UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する
        self.delegate = self
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    
}
