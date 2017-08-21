//
//  BasicTableViewCell.swift
//  LacerApp
//
//  Created by Joan Angb on 21/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {

    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style : style, reuseIdentifier : reuseIdentifier)
        setupViews()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
    }

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
