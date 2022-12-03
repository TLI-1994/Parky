//
//  PakrsCollectionViewCell.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/23/22.
//

import UIKit
import LazyImage

class CommentsCollectionViewCell: UICollectionViewCell {
    
    let commentFig = LazyImageView()
    var commentTxt = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        commentFig.translatesAutoresizingMaskIntoConstraints = false
        commentFig.contentMode = .scaleAspectFill
        commentFig.layer.cornerRadius = 15
        commentFig.clipsToBounds = true
        contentView.addSubview(commentFig)
        
        //commentTxt.placeholder = "Start a new review"
        commentTxt.font = UIFont(name: "Futura", size: 15)
        commentTxt.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        commentTxt.textAlignment = .left
        commentTxt.isEditable = false
        commentTxt.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentTxt)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        commentFig.snp.makeConstraints { make in
            make.centerY.equalTo(commentTxt.snp.centerY)
            make.height.width.equalTo(commentTxt.snp.height)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        commentTxt.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-149)
        }
        
    }
    
    func configure(comment: Comment) {
        commentTxt.text = comment.comment
        if (comment.img == "") {
            commentFig.image = UIImage(systemName: "car.fill")
        } else if (comment.img == "First") {
            commentFig.image = UIImage(systemName: "message.circle.fill")
        } else {
            commentFig.imageURL = comment.img
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
