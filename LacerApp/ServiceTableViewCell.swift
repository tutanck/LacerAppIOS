//
//  ServiceTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var serviceLabel: UILabel!
    
    @IBOutlet weak var serviceSwitch: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
