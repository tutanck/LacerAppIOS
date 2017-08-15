//
//  Fire.swift
//  LacerApp
//
//  Created by Joan Angb on 15/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class Fire{
    
    //MARK : static refs
    
    static let rootRef = Database.database().reference()
    
    static let usersRef = rootRef.child("users")
    
    //MARK : static ref keys
    
    static let userStatus = "status"

    
}
