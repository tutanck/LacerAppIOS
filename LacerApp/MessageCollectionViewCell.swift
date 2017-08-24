//
//  MessageCollectionViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 23/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: BasicCollectionViewCell {
    
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
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]|", views: profileImageView)
    }
    
    
    func makeup(style : Style) -> MessageCollectionViewCell {
        
        switch style {
        case .full:
            self.profileImageView.isHidden = false
            self.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            self.messageTextView.textColor = .black
        case .light :
            self.profileImageView.isHidden = true
            self.textBubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
            self.messageTextView.textColor = .white
        }
        
        return self //#fluent
        
    }
    
    
    
    enum Style {
        case full , light
    }
    
}
