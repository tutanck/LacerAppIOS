//
//  UserKeywordsColl.swift
//  LacerApp
//
//  Created by Joan Angb on 05/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserKeywordsColl {
    
    static let name = "user_keywords"
    static let tag = "#"+name
    
    
    static func findUserKeywords(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.find(
                coll: name,
                query: [
                    "ownerID":userID,
                    "deleted": ["$ne": true]
                ],
                opt: [
                    "title": 1,
                    "active": 1
                ],
                ack: ack)
        }
    }
    
}
