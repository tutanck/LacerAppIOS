//
//  KeywordTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 22/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class KeywordTableViewCell: BasicTableViewCell {
    
    //userProfileImageView
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let keywordLabel: UILabel = {
        let label = UILabel()
        label.text = "JavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJavaJava"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let activSwitch: UISwitch = {
        let uiswitch = UISwitch()
        uiswitch.isOn = true
        return uiswitch
    }()
    
    
    
    override func setupViews() {
        setupContentView()
    }
    
    fileprivate func setupContentView() {
        addSubview(keywordLabel)
        addSubview(activSwitch)
        
        addConstraintsWithFormat("H:|-24-[v0]-12-[v1(60)]-2-|", views: keywordLabel,activSwitch)
        addCenteredYConstraint(about: keywordLabel, to: self)
        
        addCenteredYConstraint(about: activSwitch, to: self)
        
        addConstraintsWithFormat("V:[v0(24)]", views: keywordLabel)
        addConstraintsWithFormat("V:[v0(24)]", views: activSwitch)
        
    }
    
    
}
