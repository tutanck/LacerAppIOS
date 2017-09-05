//
//  UserKeyword.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserKeyword : Snapshot {
    
    var title : String
    var active : Bool
    
    init (
        _id :String,
        _date : String,
        
        title : String,
        active : Bool
        ){
        
        self.title = title
        self.active = active
        
        super.init(_id : _id,
                   _date: _date)
    }
    
    init(
        snapshot: JSONObject
        ){
        
        self.title = snapshot["title"] as! String
        self.active = snapshot["active"] as! Bool
        
        super.init(_id :  snapshot["_id"] as! String,
                   _date: snapshot["_date"] as! String)
    }
    
}
