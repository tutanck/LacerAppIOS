//
//  UserContactTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 26/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserContactTableViewCell: UserTableViewCell {
    
    var context : UserContactsTableViewController?
    
    override func setupViews() {
        super.setupViews()
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToUtherProfile))
        singleTap.numberOfTapsRequired = 1;
        super.profileImageView.addGestureRecognizer(singleTap)
        super.profileImageView.isUserInteractionEnabled = true
        
        print("var context : UserContactsTableViewController?")
    }
    
    
    func goToUtherProfile(recognizer: UIGestureRecognizer) {
        print("context.performSegue(withIdentifier: segueToUtherProfile, sender: self)")
        if let context = context {
            context.performSegue(withIdentifier: "segueToUtherProfile", sender: self)
        }
    }
    
}
