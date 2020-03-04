//
//  PostData.swift
//  Instagram
//
//  Created by ShibayamaKentaro on 2020/02/25.
//  Copyright © 2020 KKK. All rights reserved.
//

import Firebase
import UIKit

class PostData: NSObject {
    var id: String

    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [String] = []
    var commentLabeltext = ""
    var commentnumbers = 0
    var humanid: String?

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.humanid = postDic["humanid"] as? String

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
        if let comments = postDic["comments"] as? [String] {
            self.comments = comments
        }
        if comments.count >= 1 {
            commentnumbers = comments.count
            for index in 0...commentnumbers - 1 {
                self.commentLabeltext = "\(commentLabeltext)\(comments[index])"
            }

            print("確認")
            print(commentLabeltext)
            print(commentnumbers)
            print(comments)
        }
    }
}
