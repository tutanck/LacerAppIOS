//
//  MatchingProfileTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 30/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class MatchingProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var userstatusSpot: Spot!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
