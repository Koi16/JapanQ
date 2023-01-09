//
//  LibraryViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/11.
//

import UIKit

class LibraryViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Profileのpopoverの設定
    // 前準備
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        let popoverCtrl = segue.destination.popoverPresentationController
        // 呼び出し元がUIButtonの場合
        if sender is UIButton {
            // タップされたボタンの領域を取得
            popoverCtrl?.sourceRect = (sender as! UIButton).bounds
        }
        popoverCtrl?.delegate = self
    }
    // 表示スタイルの設定
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // .noneを設定することで、設定したサイズでポップオーバーされる
        return .none
    }


}
