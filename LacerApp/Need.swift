//
//  Need.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class Need {
    
    var title : String
    var tags : String
    var activ : Bool
    
    var username : String
    var distance : Double
    var description : String
    var photo : UIImage?

    
    init(title : String,tags : String, activ : Bool, username : String, distance: Double, description : String, photo : UIImage?) {
        self.title = title
        self.tags = tags
        self.activ = activ

        self.username = username
        self.distance = distance
        self.description = description
        self.photo = photo
        
     }
}
