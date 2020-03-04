//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by ShibayamaKentaro on 2020/02/28.
//  Copyright © 2020 KKK. All rights reserved.
//

import Firebase
import FirebaseUI
import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet var postImageView: UIImageView!
    
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var likeLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var captionLabel: UILabel!
    
    @IBOutlet var commentButton: UIButton!
    
    @IBOutlet var commentLabel: UILabel!
    
    @IBOutlet var commentdeleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // contentsのサイズに合わせてobujectのサイズを変える
        // captionLabel.sizeToFit()
        // commentLabel.sizeToFit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        commentLabel.text = postData.commentLabeltext
    }
}
