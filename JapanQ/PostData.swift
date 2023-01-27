//
//  PostData.swift
//  JapanQ
//
//  Created by Takahiro Koizumi on 2023/01/10.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var uid: String?
    var name: String?
    var title: String?
    var storeName: String?
    var text: String?
    var date: Date?
    var coments: [String] = []
    
    var imageId: String?

//    var likes: [String] = []
//    var isLiked: Bool = false
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        self.uid = Auth.auth().currentUser!.uid
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.title = postDic["title"] as? String
        
        self.storeName = postDic["storeName"] as? String
        
        self.text = postDic["text"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        //変数として使えるようにする（？）
        if  let coments = postDic["coments"] as? [String] {
            self.coments = coments
        }
        self.imageId = postDic["imageId"] as? String

//        if let likes = postDic["likes"] as? [String] {
//            self.likes = likes
//        }
//        if let myid = Auth.auth().currentUser?.uid {
//            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
//            if self.likes.firstIndex(of: myid) != nil {
//                // myidがあれば、いいねを押していると認識する。
//                self.isLiked = true
//            }
//        }
    }
    
}

