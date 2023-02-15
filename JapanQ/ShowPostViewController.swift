//
//  ShowPostViewController.swift
//  JapanQ
//
//  Created by Takahiro Koizumi on 2023/01/13.
//

import UIKit
import Firebase
import FirebaseStorageUI


class ShowPostViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var comentsTextView: UITextView!
    @IBOutlet weak var seeAllComentsButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var comentsLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var postData: PostData!
//    var indexPath: IndexPath!
//    var postArray: [PostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "6884AD")
        backButton.tintColor = UIColor.white
        titleLabel.textColor = UIColor.white
        storeNameLabel.textColor = UIColor.white
        captionTextView.textColor = UIColor.white
        captionTextView.backgroundColor = UIColor(hex: "53698a")
        comentsTextView.textColor = UIColor.white
        comentsTextView.backgroundColor = UIColor(hex: "53698a")
        seeAllComentsButton.tintColor = UIColor.lightGray
        comentsLabel.textColor = UIColor.white
        captionLabel.textColor = UIColor.white
        dateLabel.textColor = UIColor.opaqueSeparator
        
        
        let imageId = postData.id + ".jpg"
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(imageId)
        imageView.sd_setImage(with: imageRef)
        
        // titleの表示
        self.titleLabel.text = "\(postData.title!)"
        // storenameの表示
        if let store = postData.storeName{
            self.storeNameLabel.text = "\(store)"
        }
        
        //textの表示
        self.captionTextView.text = "\(postData.text!)"

        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        //comentsTextView.lineBreakMode = .byWordWrapping
        //コメントの表示
        var allComents = self.comentsTextView.text!

        if postData.coments.isEmpty == true {
            self.comentsTextView.text! = "コメントなし"
            self.comentsTextView.textColor = UIColor.opaqueSeparator

        }else {
            //コメントなしの消去
            allComents.removeAll()
            self.comentsTextView.textColor = UIColor.white
            if postData.coments.count >= 1 {
            if postData.coments.count == 1 {
                self.comentsTextView.text! = postData.coments.first!
            }else {
                allComents.removeAll()
                //for文で全要素改行表示
                for i in postData.coments.prefix(postData.coments.count - 1) {
                    allComents += i
                    allComents += "\n"
                    self.comentsTextView.text! = allComents
                }
                let v = postData.coments.last!
                allComents += v
                self.comentsTextView.text! = allComents
            }
            }
        }


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //comentsTextView.lineBreakMode = .byWordWrapping
print("viewdidappear")
        comentsTextView.reloadInputViews()
//        //コメントの表示
//        var allComents = self.comentsTextView.text!
//
////        if postData.coments.isEmpty == true {
////            self.comentsTextView.text! = "コメントなし"
////            self.comentsTextView.textColor = .gray
////
////        }else {
////            allComents.removeAll()
//            self.comentsTextView.textColor = .white
//        if postData.coments.count >= 1 {
//            if postData.coments.count == 1 {
//                self.comentsTextView.text! = postData.coments.first!
//            }else {
//                allComents.removeAll()
//                //for文で全要素改行表示
//                for i in postData.coments.prefix(postData.coments.count - 1) {
//                    allComents += i
//                    allComents += "\n"
//                    self.comentsTextView.text! = allComents
//                }
//                let v = postData.coments.last!
//                allComents += v
//                self.comentsTextView.text! = allComents
//            }
//        }
        
    }
    
    @IBAction func seeAllComentsButton(_ sender: Any) {
        //配列からタップされたインデックスのデータを取り出す
//        let postData = postArray[indexPath!.row]
        let comentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "coments") as! ComentsViewController
        comentsViewController.postData = postData
        self.present(comentsViewController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
