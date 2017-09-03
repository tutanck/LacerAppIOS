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
    var visible : Bool
    var date : Date
    
    
    init (
        _id : String,
        title : String,
        visible : Bool,
        description : String
        ){
        
        self.title = title
        self.visible = visible
        self.description = description
        self.date = Date()
        
        super.init(_id : _id)
    }
    
    init (
        snapshot : JSONObject
        ){
        
        self.title = snapshot["title"] as! String
        self.description = snapshot["description"] as! String
        self.visible = snapshot["visible"] as! Bool
        
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
                    "visible": 1
                ],
                ack: ack)
        }
    }
    
}
