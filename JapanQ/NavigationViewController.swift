//
//  NavigationViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/16.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //userマークの色
        self.navigationBar.tintColor = UIColor.white

        //タブ背景色
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor =  UIColor(hex: "6884AD")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "PingFangHK-Medium", size: 23)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    
    
}
