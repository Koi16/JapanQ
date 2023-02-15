//
//  PopoverViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/22.
//

import UIKit
import Firebase
import SVProgressHUD

extension PopoverViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

class PopoverViewController: UIViewController {
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popoverView.tintColor = UIColor.white
        self.popoverView.backgroundColor = UIColor(hex: "6884AD")
        self.popoverView.layer.cornerRadius = 9
        self.popoverView.layer.shadowColor = UIColor.black.cgColor
        self.popoverView.layer.shadowOpacity = 0.3
        self.popoverView.layer.shadowRadius = 5.0
        self.popoverView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        self.textLabel.textColor = UIColor.white
        
        self.newNameTextField.textColor = UIColor.white
        self.newNameTextField.backgroundColor = UIColor(hex: "2d61ad")
        self.newNameTextField.layer.borderColor = UIColor.white.cgColor
        self.newNameTextField.layer.borderWidth = 1
        self.newNameTextField.layer.cornerRadius = 3
        
        self.cancelButton.tintColor = UIColor.white
        self.okButton.tintColor = UIColor.white
        
        let user = Auth.auth().currentUser
        if let user = user {
            newNameTextField.text = user.displayName
        }
    }
    
    @IBAction func okButton(_ sender: Any) {
        if let displayName = newNameTextField.text {
            //表示名が入力されていない時はHUDを出して何もしない
            if displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "アカウント名を入力してください")
                return
            }
            
            
            //表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                //名前が変更されていなかったら
                if displayName == user.displayName {
                    SVProgressHUD.showError(withStatus: "アカウント名を変更してください・")
                    return
                }
                //名前が変更されたら
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "アカウント名の変更に失敗しました。")
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        return
                    }
                    
                    
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                    //HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "アカウント名を変更しました")
                    
                    
                    self.view.endEditing(true)
                    self.dismiss(animated: true, completion: nil)
                   
                }
            }
        }
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        //self.view.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
