//
//  PostViewController.swift
//  JapanQ
//
//  Created by Takahiro Koizumi on 2023/01/04.
//

import UIKit
import Firebase
import CLImageEditor
import SVProgressHUD


class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var storeNameTextField: UITextField!
    @IBOutlet weak var textTextView: UITextView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func folderButton(_ sender: Any) {
        // ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    // 写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // UIImagePickerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
        // 画像加工処理
        if info[.originalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            // あとでCLImageEditorライブラリで加工する
            print("DEBUG_PRINT: image = \(image)")
            // CLImageEditorにimageを渡して、加工画面を起動する。
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            self.present(editor, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // UIImagePickerController画面を閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        
        imageView.image = image!
        editor.dismiss(animated: true, completion: nil)
    }
    
    // CLImageEditorの編集がキャンセルされた時に呼ばれるメソッド
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        // CLImageEditor画面を閉じる
        editor.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if let title = titleTextField.text, let storeName = storeNameTextField.text, let text = textTextView.text {
            if title.isEmpty || storeName.isEmpty || text.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                print("何かが未入力です")
                return
            }
            SVProgressHUD.show()

            if let image = imageView.image {
                let completePostViewController = self.storyboard?.instantiateViewController(withIdentifier: "complete") as! CompletePostViewController
                completePostViewController.image = image
                completePostViewController.titleStr = title
                completePostViewController.storeNameStr = storeName
                completePostViewController.textStr = text
                SVProgressHUD.dismiss()
                self.present(completePostViewController, animated: true, completion: nil)
            }
        
        }
        
    }
    
    
}
