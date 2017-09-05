//
//  BasicNeedTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 22/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedTableViewCell: BasicTableViewCell {
    
    var _id : String?
    
    //metaContainerView
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let previewLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    let isActivImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    
    override func setupViews() {
        setupMetaContainerView()
    }
    
    
    
    fileprivate func setupMetaContainerView() {
        let containerView = UIView()
        //containerView.backgroundColor = .green //debug
        addSubview(containerView)
        addConstraintsWithFormat("H:|-12-[v0]|", views: containerView)
        addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        addCenteredYConstraint(about: containerView, to: self)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(previewLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(isActivImageView)
        
        containerView.addConstraintsWithFormat("V:|[v0(24)]", views: timeLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: titleLabel, timeLabel)
        
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: titleLabel, previewLabel)
        
        containerView.addConstraintsWithFormat("H:|[v0]-8-[v1(20)]-12-|", views: previewLabel, isActivImageView)
        
        containerView.addConstraintsWithFormat("V:[v0(20)]|", views: isActivImageView)
    }
    
}
