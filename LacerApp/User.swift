//
//  User.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class User : Snapshot {
    
    var type : Int
    var username : String
    var photo : UIImage
    var status : Int
    
    
    init(
        _id : String,
        
        type : Int,
        username : String,
        photo : UIImage? = UIImage(named : "userPhoto"),
        status: Int
        ){
        
        self.type = type
        self.username = username
        self.photo = photo!
        self.status = status
        
        super.init(_id: _id)
    }
    
    
    init(
        snapshot: JSONObject
        ) {

        self.type = snapshot["type"] as! Int
        self.username = snapshot["username"] as! String
        self.status = snapshot["status"] as! Int
        self.photo =  snapshot["photo"] as? UIImage ?? UIImage(named: "userPhoto")!
        
        super.init(_id: snapshot["_id"] as! String)
    }
    
}
