//
//  HomeViewController.swift
//  SwiftQ
//
//  Created by Takahiro Koizumi on 2022/12/11.
//

import UIKit
import Firebase
import SVProgressHUD

class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 投稿データを格納する配列
    var postArray: [PostData] = []
    // Firestoreのリスナー
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white//(hex: "6884AD")
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        // ログイン済みか確認
        if Auth.auth().currentUser != nil {
            // listenerを登録して投稿データの更新を監視する
            let postsRef = Firestore.firestore().collection(Const.PostPath).order(by: "date", descending: true)
            listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                if let error = error {
                    print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                    return
                }
                // 取得したdocumentをもとにPostDataを作成し、postArrayの配列にする。
                self.postArray = querySnapshot!.documents.map { document in
                    print("DEBUG_PRINT: document取得 \(document.documentID)")
                    let postData = PostData(document: document)
                    return postData
                }

                // collectionViewの表示を更新する
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG_PRINT: viewWillDisappear")
        // listenerを削除して監視を停止する
        listener?.remove()
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //storyboard上のセルを生成　storyboardのIdentifierで付けたものをここで設定する
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.setPostData(postArray[indexPath.row])
        
        //cell.imageView.image = UIImage(named: "image" + "\(postArray[indexPath.row])")
        
        // 例としてカスタムセルそのものに影と角丸をつける
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 4
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.borderColor = UIColor(hex: "6884AD").cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGFloat = view.frame.width/2 - 15
        return CGSize(width: cellSize, height: 280)
    }
    
    // 各カスタムセル外枠の余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("タップされたよ\(indexPath.row)")
        let indexPath = indexPath
        let postData = postArray[indexPath.row]
        
        
        
        
        let showPostViewController = self.storyboard?.instantiateViewController(withIdentifier: "showpost") as! ShowPostViewController
        
        let comentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "coments") as! ComentsViewController
                comentsViewController.postData = postData
        showPostViewController.postData = postData
        self.present(showPostViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //投稿
    @IBAction func postButton(_ sender: Any) {
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "post")
        present(postViewController!, animated: true, completion: nil)
    }
    
    //Profileのpopoverの設定
    // 前準備
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // セグエのポップオーバー接続先を取得
        let popoverCtrl = segue.destination.popoverPresentationController
        // 呼び出し元がUIButtonの場合
        if sender is UIButton {
            // タップされたボタンの領域を取得
            popoverCtrl?.sourceRect = (sender as! UIButton).bounds
        }
        // デリゲートを自分自身に設定
        popoverCtrl?.delegate = self
    }
    
    // 表示スタイルの設定
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // .noneを設定することで、設定したサイズでポップオーバーされる
        return .none
    }
    
}
