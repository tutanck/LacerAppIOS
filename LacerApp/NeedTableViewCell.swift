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
        label.text = "MarkZuckerbergMarkZuckerbergMarkZuckerbergMarkZuckerbergMarkZuckerberg"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "2000km200m200m200m200m200m200m200m200m200m200m200m200m200m200m200m200m200m"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    
    
    //detailsContainerView
    let messageLabel: UILabel = {
     let label = UILabel()
     label.text = "YourfriendsmessageandsomethingelseYourfriendsmessageandsomethingelse"
     label.textColor = UIColor.darkGray
     label.font = UIFont.systemFont(ofSize: 14)
     return label
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
        containerView.backgroundColor = .blue
        addSubview(containerView)
        addConstraintsWithFormat("H:|-84-[v0]-6-|", views: containerView)
        addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        addCenteredYConstraint(about: containerView, to: self.userProfileImageView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(distanceLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0]-12-|", views: titleLabel)
        
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: titleLabel, usernameLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0][v1(75)]-12-|", views: usernameLabel,distanceLabel)
        
        containerView.addConstraintsWithFormat("V:[v0(24)]|", views: distanceLabel)
        
    }
    
    
    fileprivate func setupDetailsContainerView() {
        
        let containerView = UIView()
        containerView.backgroundColor = .green
        addSubview(containerView)
        addConstraintsWithFormat("H:|-6-[v0]-6-|", views: containerView)
        addConstraintsWithFormat("V:[v0(120)]-2-|", views: containerView)
        addCenteredXConstraint(about: containerView, to: self)
        
        
        /*containerView.addSubview(titleLabel)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(distanceLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0]-12-|", views: titleLabel)
        
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: titleLabel, usernameLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: usernameLabel,distanceLabel)
        
        containerView.addConstraintsWithFormat("V:[v0(24)]|", views: distanceLabel)
        
        */
        
    }
    
}
