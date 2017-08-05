//
//  UtherNeedTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UtherNeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
     
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var keywordsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
