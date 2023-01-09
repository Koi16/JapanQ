//
//  ProfileViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/11.
//

import UIKit
import Firebase

extension ProfileViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        let user = Auth.auth().currentUser
        self.userNameLabel.text = user?.displayName
        self.mailLabel.text = user?.email
    }
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var changeProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailLabel.textColor = UIColor.gray
        self.changeProfileButton.tintColor = UIColor.white
        self.changeProfileButton.backgroundColor = UIColor(hex: "6884AD")
        self.changeProfileButton.layer.cornerRadius = 7
        self.changeProfileButton.layer.shadowColor = UIColor.black.cgColor
        self.changeProfileButton.layer.shadowOpacity = 0.3
        self.changeProfileButton.layer.shadowRadius = 5.0
        self.changeProfileButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        let user = Auth.auth().currentUser
        self.userNameLabel.text = user?.displayName
        self.mailLabel.text = user?.email
    }
    @IBAction func changeProfileButton(_ sender: Any) {
//        let settingViewController = self.storyboard?.instantiateViewController(withIdentifier: "setting")
//        present(settingViewController!, animated: true, completion: nil)
        let settingViewController = storyboard?.instantiateViewController(identifier: "setting") as! SettingViewController
        settingViewController.presentationController?.delegate = self
        self.present(settingViewController, animated: true, completion: nil)
    }
    
}
