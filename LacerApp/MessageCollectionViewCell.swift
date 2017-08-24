//
//  MessageCollectionViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 23/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: BasicCollectionViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.backgroundColor = .clear
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "DateDateDateDateDateDateDateDateDateDateDateDateDateDateDateDateDateDate"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        addSubview(dateLabel)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]-24-|", views: profileImageView)
        
        addConstraintsWithFormat("V:[v0(30)]|", views: dateLabel)
    }
    
    
    func makeup(style : Style, margin : CGFloat) -> MessageCollectionViewCell {
        switch style {
        case .full:
            self.profileImageView.isHidden = false
            self.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            self.messageTextView.textColor = .black
            addConstraintsWithFormat("H:|-\(margin)-[v0(100)]", views: dateLabel)
        case .light :
            self.profileImageView.isHidden = true
            self.textBubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
            self.messageTextView.textColor = .white
            addConstraintsWithFormat("H:[v0(100)]-\(margin)-|", views: dateLabel)
        }
        
        return self //#fluent
        
    }
        
    
    enum Style {
        case full , light
    }
    
}
