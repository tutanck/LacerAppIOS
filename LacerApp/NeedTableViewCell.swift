//
//  NeedTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 22/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class NeedTableViewCell: BasicTableViewCell {
    
    //userProfileImageView
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    
    //metaContainerView
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ChauffeurChauffeurChauffeurChauffeurChauffeurChauffeur"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "MarkZuckerbergMarkZuckerbergMarkZuckerbergMarkZuckerberg"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "2000km200m200m200m200m200m200m200m200m200m200m200m200m200m"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    
    
    //detailsContainerView
    let keywordsLabel: UILabel = {
        let label = UILabel()
        label.text = "#keyword#keyword#keyword#keyword#keyword#keyword#keyword#"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "YourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyoursYourfriendsmessageandsomethingelseYourfriendsmessageandyours"
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        //textView.isSelectable = false
        return textView
    }()
    
    
    
    override func setupViews() {
        setupUserProfileImageView()
        setupMetaContainerView()
        setupDetailsContainerView()
    }
    
    
    fileprivate func setupUserProfileImageView() {
        
        addSubview(userProfileImageView)
        
        userProfileImageView.image = UIImage(named: "userPhoto")
        
        addConstraintsWithFormat("H:|-6-[v0(68)]", views: userProfileImageView)
        addConstraintsWithFormat("V:|-6-[v0(68)]", views: userProfileImageView)
        
    }
    
    
    fileprivate func setupMetaContainerView() {
        
        let containerView = UIView()
        //containerView.backgroundColor = .blue //debug
        addSubview(containerView)
        addConstraintsWithFormat("H:|-80-[v0]-6-|", views: containerView)
        addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        addCenteredYConstraint(about: containerView, to: self.userProfileImageView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(distanceLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0]|", views: titleLabel)
        
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: titleLabel, usernameLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0][v1(75)]|", views: usernameLabel,distanceLabel)
        
        containerView.addConstraintsWithFormat("V:[v0(24)]|", views: distanceLabel)
        
    }
    
    
    fileprivate func setupDetailsContainerView() {
        
        let containerView = UIView()
        //containerView.backgroundColor = .green //debug
        addSubview(containerView)
        addConstraintsWithFormat("H:|-6-[v0]-6-|", views: containerView)
        addConstraintsWithFormat("V:[v0(120)]-2-|", views: containerView)
        addCenteredXConstraint(about: containerView, to: self)
        
        //tagsLabel.backgroundColor = .yellow //debug
        containerView.addSubview(keywordsLabel)
        containerView.addSubview(dividerLineView)
        //descriptionLabel.backgroundColor = .red //debug
        containerView.addSubview(descriptionTextView)
        
        containerView.addConstraintsWithFormat("H:|-80-[v0]|", views: keywordsLabel)
        containerView.addConstraintsWithFormat("H:|-80-[v0]|", views: dividerLineView)

        containerView.addConstraintsWithFormat("V:|[v0(24)]-2-[v1(1)]", views: keywordsLabel,dividerLineView)

        containerView.addConstraintsWithFormat("H:|-2-[v0]|", views: descriptionTextView)

        containerView.addConstraintsWithFormat("V:[v0]-2-[v1]|", views: dividerLineView,descriptionTextView)


//        containerView.addConstraintsWithFormat("H:|[v0]|", views: descriptionLabel)
    }
    
}
