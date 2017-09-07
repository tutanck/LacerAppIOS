//
//  UserNeed.swift
//  LacerApp
//
//  Created by Joan Angb on 16/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserNeed : Snapshot {
    
    var title : String
    var searchText : String
    var active : Bool
    
    
    init (
        _id : String,
        
        title : String,
        active : Bool,
        searchText : String
        ){
        
        self.title = title
        self.active = active
        self.searchText = searchText
        
        super.init(_id : _id)
    }
    
    
    init (
        snapshot : JSONObject
        ){
        
        self.title = snapshot["title"] as! String
        self.searchText = snapshot["searchText"] as! String
        self.active = snapshot["active"] as! Bool
        
        super.init(_id : snapshot["_id"] as! String)
    }
    
}
