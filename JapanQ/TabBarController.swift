//
//  TabBarController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/12.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タブアイコンの色
//        self.tabBar.unselectedItemTintColor = UIColor(hex: "d4e5fc")
//        self.tabBar.tintColor = UIColor(hex: "063475")
        //タブ背景色
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  UIColor(hex: "6884AD")
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        UITabBar.appearance().tintColor = UIColor.white
//      self.tabBar.unselectedItemTintColor = UIColor(hex: "d4e5fc")
//        self.tabBar.tintColor = UIColor(hex: "063475")
        
        //UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する
        self.delegate = self
        
    }
    
    //タップしたとき
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Tabbar出現")

        if Auth.auth().currentUser == nil {
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
        

    }
    
}
