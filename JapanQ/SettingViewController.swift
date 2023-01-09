//
//  SettingViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/11.
//

import UIKit
import Firebase

extension SettingViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        let user = Auth.auth().currentUser
        self.userNameTextLabel.text = user?.displayName
        self.mailTextLabel.text = user?.email
    }
}
extension SettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

class SettingViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var mailTextLabel: UILabel!
    @IBOutlet weak var passwordTextLabel: UILabel!
    @IBOutlet weak var howManyPostTextLabel: UILabel!
    
    @IBOutlet weak var editUserNameButton: UIButton!
    @IBOutlet weak var editMailButton: UIButton!
    @IBOutlet weak var editPasswordButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editUserNameButton.tintColor = UIColor.white
        self.editUserNameButton.backgroundColor = UIColor(hex: "6884AD")
        self.editUserNameButton.layer.cornerRadius = 2
        
        self.editMailButton.tintColor = UIColor.white
        self.editMailButton.backgroundColor = UIColor(hex: "6884AD")
        self.editMailButton.layer.cornerRadius = 2
        
        self.editPasswordButton.tintColor = UIColor.white
        self.editPasswordButton.backgroundColor = UIColor(hex: "6884AD")
        self.editPasswordButton.layer.cornerRadius = 2
        
        self.logoutButton.tintColor = UIColor.white
        self.logoutButton.backgroundColor = UIColor(hex: "cf3450")
        self.logoutButton.layer.cornerRadius = 7
        self.logoutButton.layer.shadowColor = UIColor.black.cgColor
        self.logoutButton.layer.shadowOpacity = 0.3
        self.logoutButton.layer.shadowRadius = 5.0
        self.logoutButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        self.cancelButton.tintColor = UIColor(hex: "6884AD")
        
        
        //TextFieldにそれぞれの情報を入れる
        let user = Auth.auth().currentUser
        self.userNameTextLabel.text = user?.displayName
        self.mailTextLabel.text = user?.email
        
        //        self.userNameTextLabel.reloadInputViews()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("viewDidAppear")
        super.viewDidAppear(animated)
        let user = Auth.auth().currentUser
        self.userNameTextLabel.text = user?.displayName
        self.mailTextLabel.text = user?.email
        //refresh()
    }
    
    //    func refresh() {
    //        let user = Auth.auth().currentUser
    //        self.userNameTextLabel.text = user?.displayName
    //        self.mailTextLabel.text = user?.email
    //    }

    
    @IBAction func editUserNameButton(_ sender: Any) {
      //  let popoverViewController = self.storyboard?.instantiateViewController(withIdentifier: "userName")
        let popoverViewController = storyboard?.instantiateViewController(identifier: "userName") as! PopoverViewController
        popoverViewController.presentationController?.delegate = self
        self.present(popoverViewController, animated: true, completion: nil)
    }
    
    @IBAction func editMailButton(_ sender: Any) {
    }
    @IBAction func editPasswordButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        let email = user?.email
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert = UIAlertController(title: "パスワードを変更する", message: "\(email!)にURLを送信します。", preferredStyle:  UIAlertController.Style.alert)

        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                DispatchQueue.main.async {
                    if error != nil {
                        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                        self.present(loginViewController!, animated: true, completion: nil)
                        //                          self.alert(title: "メールを送信しました。", message: "メールでパスワードの再設定を行ってください。", actiontitle: "OK")
                    } else {
                        print("エラー：\(String(describing: error?.localizedDescription))")
                        //                          self.alert(title: "エラー", message: "このメールアドレスは登録されてません。", actiontitle: "OK")
                    }
                }
            })
        })
        // キャンセルボタン
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })

        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        // ④ Alertを表示
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        //ログアウトする
        try! Auth.auth().signOut()
        //ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
