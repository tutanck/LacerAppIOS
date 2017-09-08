//
//  UserProfilesColl.swift
//  LacerApp
//
//  Created by Joan Angb on 04/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserProfilesColl {
    
    static let name = "user_profiles"
    static let tag = "#"+name
    
    
    static func findUserProfile(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.find(
                coll: name,
                query: ["_id":userID],
                ack: ack)
        }
    }
    
    
    static func findProfile(
        userID : String,
        ack : @escaping ([Any]) -> ()
        ){
        IO.r.find(
            coll: name,
            query: ["_id" : userID],
            ack: ack)
    }
    
    
    static func findProfiles(
        username : String,
        type : Int? = nil,
        ack : @escaping ([Any]) -> ()
        ){
        
        var query : [String:Any] = [
            "username":[
                "$regex": "^"+username,
                "$options": "i"
            ]
            ,"_id" : ["$ne":UserInfos._id]
        ]
        
        if let type = type { query["type"] = type }
        
        IO.r.find(
            coll: name,
            query:query,
            opt: ["limit":5],
            ack: ack)
    }
    
    
}
