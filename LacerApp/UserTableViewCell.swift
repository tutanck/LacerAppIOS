//
//  UserTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 21/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserTableViewCell: BasicTableViewCell {
    
    //userProfileImageView
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "userPhoto")
        return imageView
    }()
    
    
    
    //metaContainerView
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your friend's message and something else..."
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    
    override func setupViews() {
        setupUserProfileImageView()
        setupMetaContainerView()
     }
    
    
    fileprivate func setupUserProfileImageView() {
        addSubview(profileImageView)
        addConstraintsWithFormat("H:|-6-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(68)]", views: profileImageView)
        addCenteredYConstraint(about: profileImageView, to: self)
                
    }
    
    
    
    fileprivate func setupMetaContainerView() {
        let containerView = UIView()
        //containerView.backgroundColor = .green //debug
        addSubview(containerView)
        addConstraintsWithFormat("H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        addCenteredYConstraint(about: containerView, to: self)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraintsWithFormat("V:|[v0(24)]", views: timeLabel)

        containerView.addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
        
        containerView.addConstraintsWithFormat("V:[v0(20)]|", views: hasReadImageView)
    }
    
}
