//
//  CommentViewController.swift
//  Instagram
//
//  Created by ShibayamaKentaro on 2020/03/03.
//  Copyright © 2020 KKK. All rights reserved.
//

import Firebase
import SVProgressHUD
import UIKit

class CommentViewController: UIViewController {
    var postData: PostData!
    
    var postArray: [PostData] = []
    
    // Firestoreのリスナー
    var listener: ListenerRegistration!
    
    @IBOutlet var commentTextView: UITextView!
    
    @IBAction func sendButton(_ sender: Any) {
        var update: FieldValue
        
        var displayname: String? = Auth.auth().currentUser?.displayName
        
        var comment: String? = commentTextView.text
        
        var commentdata = "\(displayname!)\(":")\(comment!)\n"
        
        update = FieldValue.arrayUnion([commentdata])
        
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        postRef.updateData(["comments": update])
        
        SVProgressHUD.showSuccess(withStatus: "コメントしました")
        commentTextView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
