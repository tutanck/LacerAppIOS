//
//  UserStarsSnap.swift
//  LacerApp
//
//  Created by Joan Angb on 08/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserStarsSnap : Snap {
    
    static let starsFromUserTag = UserStarsColl.tag+"/fromID:"+UserInfos._id!
    
    
    var toID : String
    var stars : Int
    
    
    init?(
        toID: String,
        stars: Int,
        
        ack: @escaping ([Any]) -> (),
        meta : JSONObject?=nil,
        timeout : Double? = 0
        ){
        
        self.toID = toID
        self.stars = stars
        
        let meta =
        
        meta == nil ?
             ["tags":
                [
                    ["kind" : "emit",
                     "val" : UserStarsSnap.starsFromUserTag+"/toID:"+toID]
                ]
            ]
            : meta
        
        print("meta:\(meta!)")
        
        super.init(
            regina: IO.r,
            coll: UserStarsColl.name,
            ack: ack,
            timeout: timeout,
            query: ["fromID":UserInfos._id!, "toID":toID],
            meta: meta!,
            opt : ["upsert":true]
        )
    }
    
    
    
    public override func render()->JSONObject {
        return [
            "fromID" : UserInfos._id!
            ,"toID" : toID
            ,"stars" : stars
        ]
    }
    
    
    
}
