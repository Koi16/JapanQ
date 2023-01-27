//
//  CollectionViewCell.swift
//  JapanQ
//
//  Created by Takahiro Koizumi on 2023/01/10.
//

import UIKit
import Firebase
import FirebaseStorageUI


class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(hex: "6884AD")
        layer.cornerRadius = 12
        layer.borderWidth = 2
        //comentsLabel.lineBreakMode = .byWordWrapping

    }
    func setPostData(_ postData: PostData) {
        // 画像の表示
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
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
        self.textLabel.text = "\(postData.text!)"

        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
    }
    
}
