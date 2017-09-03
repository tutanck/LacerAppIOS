//
//  UserNeedShot.swift
//  LacerApp
//
//  Created by Joan Angb on 16/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedShot : Shot {
    
    //Constants
    static let regina = IO.r
    static let coll = DB.user_needs
    static var collTag = DB.user_needs_tag
    
    var title : String
    var description : String
    var active : Bool
    var date : Date
    
    
    init (
        _id : String,
        title : String,
        active : Bool,
        description : String
        ){
        
        self.title = title
        self.active = active
        self.description = description
        self.date = Date()  //TODO
        
        super.init(_id : _id)
    }
    
    init (
        snapshot : JSONObject
        ){
        
        self.title = snapshot["title"] as! String
        self.description = snapshot["description"] as! String
        self.active = snapshot["active"] as! Bool
        
        self.date = Date()
        
        super.init(_id :  snapshot["_id"] as! String)
    }
    
    
    static func find(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            regina.find(
                coll: UserNeedShot.coll,
                query: ["ownerID":userID],
                opt: [
                    "title": 1,
                    "description": 1,
                    "active": 1
                ],
                ack: ack)
        }
    }
    
}
