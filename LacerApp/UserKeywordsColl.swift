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
    
    static let meta = ["tags":
        [
            ["kind" : "io",
             "val" : tag+"/"+UserInfos._id!],
            ["kind" : "io",
             "val" : tag]
        ]
    ]
    
    
    static func deleteUserKeyword(
        _id : String,
        ack : @escaping ([Any]) -> (),
        meta : JSONObject? = meta
        ){
        if let userID = UserInfos._id {
            IO.r.remove(coll: name, query: ["_id":_id], meta : meta, ack: ack)
        }
    }
    
    
    static func findUserKeywords(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.find(
                coll: name,
                query: ["ownerID":userID],
                opt: [
                    "title": 1,
                    "active": 1,
                    "_date": 1
                ],
                ack: ack)
        }
    }
    
}
