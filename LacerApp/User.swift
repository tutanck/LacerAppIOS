//
//  User.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class User : Snapshot {
    
    var username : String
    var photo : UIImage
    var status : Int
    
    
    init(
        _id : String,
        _date : String,
        
        username : String,
        photo : UIImage? = UIImage(named : "userPhoto"),
        status: Int
        ){
        
        self.username = username
        self.photo = photo!
        self.status = status
        
        super.init(_id: _id,
                   _date: _date)
    }
    
    
    init(
        snapshot: JSONObject
        ) {
        self.username = snapshot["username"] as! String
        self.status = snapshot["status"] as! Int
        self.photo =  snapshot["photo"] as? UIImage ?? UIImage(named: "userPhoto")!
        
        super.init(_id: snapshot["_id"] as! String,
                   _date: snapshot["date"] as! String)
    }
    
}
