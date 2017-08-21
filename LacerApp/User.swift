//
//  User.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class User {
    
    let nameKey = "name"
    let statusKey = "status"
    
    let ref: DatabaseReference?

    
    var name : String
    
    var photo : UIImage?
    
    var status : Int
    
    
    init(name : String, photo : UIImage?, status: Int){
        self.name = name
        self.status = status
        self.photo = photo
        
        ref = nil
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! NSDictionary

        self.name = snapshotValue[nameKey] as! String
        self.photo = UIImage(named: "userPhoto")
        self.status = snapshotValue[statusKey] as! Int
        
        ref = snapshot.ref
    }

    
    
}
