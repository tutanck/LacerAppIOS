//
//  User.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class User {
    
    var name : String
    
    var photo : UIImage?
    
    var status : Int
    
    
    init(name : String, photo : UIImage? , status : Int) {
        self.name = name
        self.photo=photo
        self.status=status
        
    }
    
    
}
