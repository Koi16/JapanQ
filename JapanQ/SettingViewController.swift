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
    
    @IBOutlet weak var editUserNameButton: UIButton!
    @IBOutlet weak var editPasswordButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editUserNameButton.tintColor = UIColor.white
        self.editUserNameButton.backgroundColor = UIColor(hex: "6884AD")
        self.editUserNameButton.layer.cornerRadius = 2
        
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
        
        
        //TextField????????????????????????????????????
        let user = Auth.auth().currentUser
        self.userNameTextLabel.text = user?.displayName
        self.mailTextLabel.text = user?.email
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let user = Auth.auth().currentUser
        self.userNameTextLabel.text = user?.displayName
        self.mailTextLabel.text = user?.email
        //refresh()
    }
    
   

    
    @IBAction func editUserNameButton(_ sender: Any) {
        let popoverViewController = storyboard?.instantiateViewController(identifier: "userName") as! PopoverViewController
        popoverViewController.presentationController?.delegate = self
        self.present(popoverViewController, animated: true, completion: nil)
    }
    
   
    @IBAction func editPasswordButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        let email = user?.email
        
        let alert = UIAlertController(title: "??????????????????????????????", message: "\(email!)???URL?????????????????????", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ????????????????????????????????????????????????????????????????????????
            (action: UIAlertAction!) -> Void in
            print("OK")
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                DispatchQueue.main.async {
                    if error != nil {
                        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                        self.present(loginViewController!, animated: true, completion: nil)
                    } else {
                        print("????????????\(String(describing: error?.localizedDescription))")
                    }
                }
            })
        })
        // ????????????????????????
        let cancelAction = UIAlertAction(title: "???????????????", style: UIAlertAction.Style.cancel, handler:{
            // ????????????????????????????????????????????????????????????????????????
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        //?????????????????????
        try! Auth.auth().signOut()
        //?????????????????????????????????
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
