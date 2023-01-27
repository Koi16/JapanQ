//
//  CompletePostViewController.swift
//  JapanQ
//
//  Created by Takahiro Koizumi on 2023/01/05.
//

import UIKit
import Firebase
import SVProgressHUD

class CompletePostViewController: UIViewController {
    
    var image: UIImage!
    var titleStr = ""
    var storeNameStr = ""
    var textStr = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var storeNameTextLabel: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        titleTextLabel.text = titleStr
        storeNameTextLabel.text = storeNameStr
        textTextView.text = textStr
        
        self.postButton.tintColor = UIColor.white
        self.postButton.backgroundColor = UIColor(hex: "6884AD")
        self.postButton.layer.cornerRadius = 7
        self.postButton.layer.shadowColor = UIColor.black.cgColor
        self.postButton.layer.shadowOpacity = 0.3
        self.postButton.layer.shadowRadius = 5.0
        self.postButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        // 画像をJPEG形式に変換する
        let imageData = image.jpegData(compressionQuality: 0.75)
        // 画像と投稿データの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        // Storageに画像をアップロードする
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(imageData!, metadata: metadata) { (metadata, error) in
            if error != nil {
                // 画像のアップロード失敗
                print(error!)
                SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                // 投稿処理をキャンセルし、先頭画面に戻る
                self.dismiss(animated: true, completion: nil)
                return
            }
            // FireStoreに投稿データを保存する
            let name = Auth.auth().currentUser?.displayName
            let uid = Auth.auth().currentUser?.uid
            let postDic = [
                "name": name!,
                "uid": uid!, 
                "title": self.titleTextLabel.text!,
                "storeName": self.storeNameTextLabel.text!,
                "text": self.textTextView.text!,
                "date": FieldValue.serverTimestamp(),
                "imageId": postRef.documentID + ".jpg"
            ] as [String : Any]
            postRef.setData(postDic)
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            print(postRef.documentID + ".jpg")
            // 投稿処理が完了したので先頭画面に戻る
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
