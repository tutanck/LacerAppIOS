//
//  UserProfilesColl.swift
//  LacerApp
//
//  Created by Joan Angb on 04/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserProfilesColl {

    static let coll = "user_profiles"
    static let tag = "#"+coll
    
    
    static func findUserProfile(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.find(
                coll: coll,
                query: ["_id":userID],
                ack: ack)
        }
    }
    
    
    static func findProfile(
        userID : String,
        ack : @escaping ([Any]) -> ()
        ){
        IO.r.find(
            coll: coll,
            query: ["_id" : userID],
            ack: ack)
    }
    

    
}
