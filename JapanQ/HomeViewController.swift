//
//  HomeViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/11.
//

import UIKit

class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func postButton(_ sender: Any) {
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "post")
        present(postViewController!, animated: true, completion: nil)
    }
    
    //Profileのpopoverの設定
    // 前準備
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // セグエのポップオーバー接続先を取得
        let popoverCtrl = segue.destination.popoverPresentationController
        // 呼び出し元がUIButtonの場合
        if sender is UIButton {
            // タップされたボタンの領域を取得
            popoverCtrl?.sourceRect = (sender as! UIButton).bounds
        }
        // デリゲートを自分自身に設定
        popoverCtrl?.delegate = self
    }

    // 表示スタイルの設定
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // .noneを設定することで、設定したサイズでポップオーバーされる
        return .none
    }

}
