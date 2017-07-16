//
//  CustomerNeed.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class CustomerNeed : Need {
    
    var customerName : String
    var distance : Double
    var description : String
    var photo : UIImage?
    
    init(title : String,tags : String, activ : Bool, customerName : String, distance: Double, description : String, photo : UIImage?) {
        self.customerName = customerName
        self.distance = distance
        self.description = description
        self.photo = photo
        
        super.init(title: title, tags: tags, activ: activ)
    }
}
