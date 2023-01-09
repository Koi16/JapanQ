//
//  LoginViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/11.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.tintColor = UIColor.white
        self.loginButton.backgroundColor = UIColor(hex: "6884AD")
        self.loginButton.layer.cornerRadius = 7
        self.loginButton.layer.shadowColor = UIColor.black.cgColor
        self.loginButton.layer.shadowOpacity = 0.3
        self.loginButton.layer.shadowRadius = 5.0
        self.loginButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)

    }
    
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailTextField.text, let password = passwordTextField.text {
            if address.isEmpty || password.isEmpty {
                SVProgressHUD.showError(withStatus: "必須項目を入力してください")
                return
            }
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: password) {authResult, error in
                if let error = error {
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました")
                    print("エラー: " + error.localizedDescription)
                    return
                }
                print("ログインに成功しました。")
                SVProgressHUD.dismiss()
                //ホーム画面に戻る
                //self.dismiss(animated: true, completion: nil)
                let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "tab")
                self.present(tabViewController!, animated: true, completion: nil)
            }

        }
    }
    
    @IBAction func handleNewAccountButton(_ sender: Any) {
        let newAccountViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewAccount")
        present(newAccountViewController!, animated: true, completion: nil)
    }
    
}
