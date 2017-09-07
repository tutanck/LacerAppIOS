//
//  UserNeedsColl.swift
//  LacerApp
//
//  Created by Joan Angb on 04/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedsColl {
    
    static let name = "user_needs"
    static let tag = "#"+name
    
    static func findUserNeeds(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.find(
                coll: name,
                query: ["ownerID":userID],
                opt: [
                    "title": 1,
                    "searchText": 1,
                    "active": 1
                ],
                ack: ack)
        }
    }
    
    
    static func findNeed(
        needID : String,
        ack : @escaping ([Any]) -> ()
        ){
        IO.r.find(
            coll: name,
            query: ["_id" : needID],
            ack: ack)
    }
    

}
