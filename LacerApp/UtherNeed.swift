//
//  UtherNeed.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UtherNeed : UserNeed {
    
    var ownerID : String
    var description : String
    var reward : String
    var place : String
    var time : String
    //var position : Coord
    
    
    init (
        _id : String,
        
        title : String,
        active : Bool,
        searchText : String,
        
        ownerID : String,
        description : String,
        reward : String,
        place : String,
        time : String
        //position : Coord,
        ){
        
        self.ownerID = ownerID
        self.description = description
        self.reward = reward
        self.place = place
        self.time = time
        //self.position = position
        
        super.init(_id : _id,
                   title : title,
                   active : active,
                   searchText : searchText)
    }
    
    
    
    
    
    override init(
        snapshot: JSONObject
        ){
        
        self.ownerID = snapshot["ownerID"] as! String
        self.description = snapshot["description"] as! String
        self.reward = snapshot["reward"] as! String
        self.place = snapshot["place"] as! String
        self.time = snapshot["time"] as! String
        
        //self.position = snapshot["position"] as! Double
        
        super.init(_id :  snapshot["_id"] as! String,
                   title: snapshot["title"] as! String,
                   active: snapshot["active"] as! Bool,
                   searchText: snapshot["searchText"] as! String)
    }
    
    
}
