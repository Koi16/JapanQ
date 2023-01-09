//
//  NewAccountViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/11.
//

import UIKit
import Firebase
import SVProgressHUD

class NewAccountViewController: UIViewController {
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var newAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newAccountButton.tintColor = UIColor.white
        self.newAccountButton.backgroundColor = UIColor(hex: "6884AD")
        self.newAccountButton.layer.cornerRadius = 7
        self.newAccountButton.layer.shadowColor = UIColor.black.cgColor
        self.newAccountButton.layer.shadowOpacity = 0.3
        self.newAccountButton.layer.shadowRadius = 5.0
        self.newAccountButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
    }
    
    @IBAction func handleNewAccount(_ sender: Any) {
        if let address = mailTextField.text, let password = passwordTextField.text, let userName = userNameTextField.text {
            
            //メアドとパスワードとアカウント名のどれかが入力されていないとエラー
            if address.isEmpty || password.isEmpty || userName.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                print("何かが未入力です")
                return
            }
            
            SVProgressHUD.show()
            
            //アカウント作成
            Auth.auth().createUser(withEmail: address, password: password) { authResult, error in
                if let error = error {
                    SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました。")
                    print("エラー：" + error.localizedDescription)
                    return
                }
                print("ユーザー作成に成功しました")
                
                //アカウント名の設定
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = userName
                    changeRequest.commitChanges{ error in
                        if let error = error {
                            SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました。")
                            print("エラー:" + error.localizedDescription)
                            return
                        }
                        print("[userName = \(user.displayName!)]の設定に成功しました")
                        SVProgressHUD.dismiss()
                        //RootViewdismissは最初に表示される画面以外削除
                        //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                        let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "tab")
                        self.present(tabViewController!, animated: true, completion: nil)
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func handleBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
