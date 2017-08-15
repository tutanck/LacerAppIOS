//
//  UserKeywordTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class UserKeywordTableViewCell: UITableViewCell {
    
    var ref : DatabaseReference?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBAction func switchStatus(_ sender: UISwitch) {
        ref?.setValue(statusSwitch.isOn)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
