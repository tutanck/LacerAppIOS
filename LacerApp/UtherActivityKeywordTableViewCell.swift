//
//  UtherActivityKeywordTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 08/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UtherActivityKeywordTableViewCell: BasicTableViewCell {
    
    var _id :String?
    
    let keywordLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    
    
    
    override func setupViews() {
        setupContentView()
    }
    
    fileprivate func setupContentView() {
        addSubview(keywordLabel)
        addConstraintsWithFormat("H:|-24-[v0]", views: keywordLabel)
        addCenteredYConstraint(about: keywordLabel, to: self)
        addConstraintsWithFormat("V:[v0(24)]", views: keywordLabel)
    }
    
    
    
    
    
}

